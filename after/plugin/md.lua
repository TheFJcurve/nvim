vim.api.nvim_create_user_command("Compile", function()
  local file = vim.fn.expand("%:p")
  if not file:match("%.md$") then
    vim.notify("Not a markdown file", vim.log.levels.WARN)
    return
  end

  vim.notify("Compiling " .. vim.fn.expand("%:t") .. "...")
  vim.fn.jobstart({ "md-to-pdf", file }, {
    detach = false,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Compiled successfully", vim.log.levels.INFO)
      else
        vim.notify("Compilation failed (exit " .. code .. ")", vim.log.levels.ERROR)
      end
    end,
  })
end, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  callback = function()
    vim.cmd("Compile")
  end,
})
