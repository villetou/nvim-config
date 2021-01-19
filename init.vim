" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

:set number

map <SPACE> <leader>
nmap <leader>fw :w!<cr>

nmap <leader>pf :FZF<cr>
nmap <leader>w <C-w>

nmap <leader>sf :BLines
nmap <leader>ss /
nmap <leader>sp :Rg

nmap <leader>op :NERDTreeToggle<cr>

let g:onedark_terminal_italics = 1
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

:set ignorecase
:set smartcase

:set mouse=a

syntax on
colorscheme onedark
