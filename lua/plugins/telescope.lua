return {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
				local builtin = require('telescope.builtin')
				vim.keymap.set('n', '<leader>pp', builtin.git_files, {})
				vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
				vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
				vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
				vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
				vim.keymap.set('n', '<leader>pc', builtin.colorscheme, {})
		end
}
