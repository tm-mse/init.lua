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

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        formatting = lsp_zero.cmp_format({details = true}),
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select=true, behavior = cmp.ConfirmBehavior.Replace }),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
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

      require('mason-lspconfig').setup({
        ensure_installed = {"lua_ls", "terraformls", "tflint", "bashls", "yamlls", "gopls"},
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          -- this is the "custom handler" for `lua_ls`
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
					terraformls = function()
						require'lspconfig'.terraformls.setup{
							init_option = {
								terraform = {
									path = "/home/tmusete/.asdf/shims/terraform"
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
