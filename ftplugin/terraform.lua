require'lspconfig'.terraformls.setup{}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
	pattern = {"*.tf", "*.tfvars", "*.hcl"},
	callback = function()
		vim.lsp.buf.format()
			end,
})
vim.bo.commentstring = '#%s'
