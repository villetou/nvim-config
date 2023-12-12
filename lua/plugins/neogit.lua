local function setup()
	local neogit = require('neogit')
	neogit.setup {}
	vim.keymap.set('', '<Space>gg', '<Cmd>Neogit<CR>')
end

return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"nvim-telescope/telescope.nvim", -- optional
		"sindrets/diffview.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
	},
	config = setup
}
