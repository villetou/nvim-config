return { 
	{ 
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end
	},
	'neovim/nvim-lspconfig',
	{
		'williamboman/mason-lspconfig.nvim',
		depends = { 	'neovim/nvim-lspconfig', 'williamboman/mason.nvim' },
		config = function()
			require("mason-lspconfig").setup {
			    ensure_installed = { "lua_ls", "rust_analyzer" },
			}

			require("lspconfig").lua_ls.setup {}
			require("lspconfig").rust_analyzer.setup {}
		end
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

}
