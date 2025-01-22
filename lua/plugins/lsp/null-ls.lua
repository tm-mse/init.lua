return {
 "nvimtools/none-ls.nvim",
 opts = function(_, opts)
   local nls = require("null-ls")
   opts.sources = vim.list_extend(opts.sources or {}, {
     nls.builtins.diagnostics.yamllint, -- Ajoute yamllint comme linter
		 nls.builtins.code_actions.gomodifytags,
     nls.builtins.code_actions.impl,
     nls.builtins.formatting.goimports,
     nls.builtins.formatting.gofumpt,
		 nls.builtins.formatting.packer,
     nls.builtins.formatting.terraform_fmt,
     nls.builtins.diagnostics.terraform_validate,
   })
 end,
}
