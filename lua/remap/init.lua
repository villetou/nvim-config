vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = " "

vim.keymap.set('', '<C-s>', '<Cmd>w<CR>')
vim.keymap.set('', '<C-w>w', '<Cmd>bd<CR>')
