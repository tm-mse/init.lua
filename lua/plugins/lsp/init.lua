return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {
				'williamboman/mason-lspconfig.nvim',
			},
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      --- if you want to know more about lsp-zero and mason.nvim
      --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      lsp_zero.on_attach(function(client, bufnr)
        	-- see :help lsp-zero-keybindings
        	-- to learn the available actions
        	lsp_zero.default_keymaps({buffer = bufnr})
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {desc="Renames all references to the symbol under the cursor.", buffer=bufnr})
      end)

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require('mason-lspconfig').setup({
        ensure_installed = {
					"lua_ls", 
					"terraformls", 
					"tflint", 
					"bashls", 
					"yamlls", 
					"gopls",
				},
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          -- this is the "custom handlers"
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
					terraformls = function()
						require'lspconfig'.terraformls.setup{
							init_options = {
								experimentalFeatures = {
									prefillRequiredFields = true,
									validateOnSave = true,
								}
							}
						}
						vim.api.nvim_create_autocmd({"BufWritePre"}, {
						  pattern = {"*.tf", "*.tfvars", "*.hcl"},
						  callback = function()
						    vim.lsp.buf.format()
						  end,
						})
					end,
					yamlls = function ()
						require'lspconfig'.yamlls.setup({
							settings = {
         			 	yaml = {
         			 	  schemas = {
         			 	    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
         			 	    ["https://json.schemastore.org/github-action.json"] = "/.github/actions/*",
         			 	    ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
         			 	    ["https://json.schemastore.org/chart.json"] = "Chart.yaml",
         			 	    ["https://json.schemastore.org/dependabot-2.0.json"] = ".github/dependabot.yml",
         			 	  },
         			 	  validate = true, -- Activer la validation des fichiers YAML
         			 	},
         			},
						})
					end,
        }
      })
    end,
  },
	{
		"b0o/schemastore.nvim",
	}

}
