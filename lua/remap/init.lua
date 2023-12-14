vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = " "

vim.keymap.set('', '<C-s>', '<Cmd>w<CR>')
vim.keymap.set('', '<C-w>w', '<Cmd>bd<CR>')

vim.keymap.set('n', "<Leader>ff", "<CMD>lua vim.lsp.buf.format()<CR>")

-- Easier movement
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')

-- Center after jump to mark
local function jumpWithCentering()
	return "'" .. vim.fn.nr2char(vim.fn.getchar()) .. "zz"
end

vim.keymap.set('', "'", jumpWithCentering, { silent = true, expr = true, remap = false })
