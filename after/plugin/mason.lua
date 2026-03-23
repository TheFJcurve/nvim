require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {'lua_ls', 'rust_analyzer', },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

require('mason-lspconfig').setup({
  handlers = {
    -- this first function is the "default handler"
    -- it applies to every language server without a "custom handler"
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    -- this is the "custom handler" for `biome`
    biome = function()
	    require('lspconfig').biome.setup({
		    single_file_support = false,
		    on_attach = function(client, bufnr)
			    print('hello biome')
		    end
	    })
    end,
  }
})

require("lspconfig").pylsp.setup {}
require("lspconfig").texlab.setup {}
require("lspconfig").marksman.setup {}
require("lspconfig").clangd.setup {}
require("lspconfig").ccls.setup {}
