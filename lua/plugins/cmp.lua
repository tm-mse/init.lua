return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
      },
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim", -- vs-code like pictograms
    },
		config = function()
			local lsp_zero = require('lsp-zero')
			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<CR>'] = cmp.mapping.confirm({ 
						behavior = cmp.ConfirmBehavior.Replace,
						select=true, 
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
			vim.cmd([[
			set completeopt=menuone,noinsert,noselect 
			highlight! default link CmpItemKind CmpItemMenuDefault
			]])
		end,
	}
}
  -- Autocompletion
  -- {
  --   'hrsh7th/nvim-cmp',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     {'L3MON4D3/LuaSnip'},
  -- 	{ 'saadparwaiz1/cmp_luasnip' },
  --   },
  --   config = function()
  --     -- Here is where you configure the autocompletion settings.
  --     local lsp_zero = require('lsp-zero')
  --     lsp_zero.extend_cmp()
  --
  --     -- And you can configure cmp even more, if you want to.
  --     local cmp = require('cmp')
  --     local cmp_action = lsp_zero.cmp_action()
  --
  --     cmp.setup({
  --       formatting = lsp_zero.cmp_format({details = true}),
  --       mapping = cmp.mapping.preset.insert({
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --         ['<CR>'] = cmp.mapping.confirm({ select=true, behavior = cmp.ConfirmBehavior.Replace }),
  --         ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-d>'] = cmp.mapping.scroll_docs(4),
  --         ['<C-f>'] = cmp_action.luasnip_jump_forward(),
  --         ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  --       }),
  --       snippet = {
  --         expand = function(args)
  --           require('luasnip').lsp_expand(args.body)
  --         end,
  --       },
  -- 		sources	= {
  -- 			{ name = 'luasnip' }
  -- 		},
  --     })
  --   end
  -- },

