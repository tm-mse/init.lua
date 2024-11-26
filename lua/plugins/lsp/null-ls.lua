return {
 "jose-elias-alvarez/null-ls.nvim",
 opts = function(_, opts)
   local nls = require("null-ls")
   opts.sources = vim.list_extend(opts.sources or {}, {
     nls.builtins.diagnostics.yamllint, -- Ajoute yamllint comme linter
		 nls.builtins.code_actions.gomodifytags,
     nls.builtins.code_actions.impl,
     nls.builtins.formatting.goimports,
     nls.builtins.formatting.gofumpt,
   })
 end,
}
