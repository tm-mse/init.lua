local lsp = require('lsp-zero')
-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 1},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
})

local cmp_mappings = lsp.defaults.cmp_mappings({
  --# previous and next items
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<Down>'] = cmp.mapping.select_next_item(cmp_select),

  --# scrolling documentation
  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),

  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e"] = cmp.mapping.abort(),
  ['<C-y>'] = cmp.mapping.confirm({select = true}),
  ['<CR>'] = cmp.mapping.confirm({select = false}),
  ['<Tab>'] = cmp.mapping(function(fallback)
    local col = vim.fn.col('.') - 1

    if cmp.visible() then
      cmp.select_next_item(cmp_select)
    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      fallback()
    else
      cmp.complete()
    end
  end, {'i', 's'}),
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item(cmp_select)
    else
      fallback()
    end
  end, {'i', 's'}),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.setup({
  on_attach = function(client, bufnr)
  --lsp.default_keymaps({buffer = bufnr})
  --vim.keymap.set("n", "<leader>fr", function() vim.lsp.buf.format() end, { buffer = bufnr })
  --vim.keymap.set("n", "<leader>Z", function() vim.lsp.buf.rename() end, { buffer = bufnr })
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, bufopts)
  end
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
	"lua_ls",
	"gopls",
	"terraformls",
	"tflint",
	"ansiblels",
  },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require("lspconfig").lua_ls.setup(lua_opts)
    end,
    gopls = function()
      require("lspconfig").gopls.setup({})
    end,
	terraformls = function()
	  require'lspconfig'.terraformls.setup{}
	end,
	tflint = function()
		require'lspconfig'.tflint.setup{}
	end,
	ansiblels = function()
		require'lspconfig'.ansiblels.setup{}
	end
  },
})

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = '»'})
