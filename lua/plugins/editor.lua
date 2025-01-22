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
	{
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
	},
	-- install without yarn or npm
	{
	    "iamcco/markdown-preview.nvim",
	    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	    ft = { "markdown" },
	    build = function() vim.fn["mkdp#util#install"]() end,
	},
	-- install with yarn or npm
	{
	  "iamcco/markdown-preview.nvim",
	  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	  build = "cd app && yarn install",
	  init = function()
	    vim.g.mkdp_filetypes = { "markdown" }
	  end,
	  ft = { "markdown" },
	},
}
