return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
		keys = {
			{
				"<leader>pv",
				function()
					vim.cmd("Neotree")
				end,
			},
		}
  },
	{
		"rebelot/kanagawa.nvim",
		config = function()
			vim.cmd([[colorscheme kanagawa]])
		end,
	}
}
