return {
 "jose-elias-alvarez/null-ls.nvim",
 opts = function(_, opts)
   local null_ls = require("null-ls")
   opts.sources = vim.list_extend(opts.sources or {}, {
     null_ls.builtins.diagnostics.yamllint, -- Ajoute yamllint comme linter
   })
 end,
}
