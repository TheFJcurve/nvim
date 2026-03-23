vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function()
    local file = vim.api.nvim_buf_get_name(0)
    local buf = vim.api.nvim_get_current_buf()

    local viewers = {"xdg-open" }
    local viewer = nil
    for _, v in ipairs(viewers) do
      if vim.fn.executable(v) == 1 then
        viewer = v
        break
      end
    end

    if not viewer then
      vim.notify("No PDF viewer found", vim.log.levels.ERROR)
      return
    end

    vim.fn.jobstart({ viewer, file }, { detach = true })

    vim.schedule(function()
      if vim.fn.bufnr("#") > 0 then
        vim.cmd("b#")
      else
        vim.cmd("enew")
      end
      vim.api.nvim_buf_delete(buf, { force = true })
    end)
  end,
})
