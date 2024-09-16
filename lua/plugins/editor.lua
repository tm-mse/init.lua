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
	},
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
		dependencies = {
			{"nvim-lua/plenary.nvim"},
			{"nvim-telescope/telescope-fzf-native.nvim", build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'},
			{"BurntSushi/ripgrep"},
		},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end,
  },
}
