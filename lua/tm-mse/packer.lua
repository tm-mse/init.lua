-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

    -- Great colorscheme
	use({
		"rebelot/kanagawa.nvim",
		config = function()
			vim.cmd('colorscheme kanagawa')
		end
	})

	use('nvim-treesitter/nvim-treesitter', {run =':TSUpdate'})

    -- Great fuzzy finder
	use('theprimeagen/harpoon')

    -- Undo manager
	use('mbbill/undotree')

    -- Git integration
	use('tpope/vim-fugitive')

    -- Lsp config
	use {
	
	 	'VonHeikemen/lsp-zero.nvim',
	 	requires = {
	 	  -- LSP Support
	 	  {'neovim/nvim-lspconfig'},             -- Required
	 	  {                                      -- Optional
	 	    'williamboman/mason.nvim',
	 	    build = function()
	 	      pcall(vim.cmd, 'MasonUpdate')
	 	    end,
	 	  },
	 	  {'williamboman/mason-lspconfig.nvim'}, -- Optional
	
	 	  -- Autocompletion
	 	  {'hrsh7th/nvim-cmp'},     -- Required
	 	  {'hrsh7th/cmp-nvim-lsp'}, -- Required
	 	  {'L3MON4D3/LuaSnip'},     -- Required
	 	}
	
	
	}
    -- Snippet for terraform
    use('hashivim/vim-terraform')

    -- Autocompletion for python
    use('deoplete-plugins/deoplete-jedi')

    -- Language package for vim
    use('sheerun/vim-polyglot')

end)
