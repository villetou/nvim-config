return {
	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

}
