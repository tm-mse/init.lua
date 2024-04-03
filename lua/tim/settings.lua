vim.opt.number = true -- activate line number
vim.opt.rnu = true -- activate relative line number
vim.opt.numberwidth = 3 -- reserve 3 spaces for line number
vim.opt.termguicolors = true -- necessary option for kanagawa
vim.opt.background = ''
vim.opt.autoindent = true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.backupdir="~/backups"

-- TERRAFORM SETTINGS
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf, *.hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl, set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])
