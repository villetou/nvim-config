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
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

:set number

map <SPACE> <leader>
nmap <leader>fw :w!<cr>

nmap <leader>pf :FZF<cr>
nmap <leader>w <C-w>
nmap <C-w>w :W<cr>
nmap <leader>sf :BLines
nmap <leader>ss /
nmap <leader>sp :Rg

nmap <leader>op :NERDTreeToggle<cr>
nmap <leader>of :!open %:p:h<cr>
nmap <leader>ot :let $VIM_DIR=expand('%:p:h')<cr>:term<cr>icd $VIM_DIR<cr>

nmap <leader>cd :call CocActionAsync('jumpDefinition')<cr>
nmap <leader>cD <Plug>(coc-references)

nmap <leader>gg :Gstatus<cr>

let g:onedark_terminal_italics = 1
let g:lightline = {
	\ 'colorscheme': 'onedark',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status',
	\   'fugitive': 'fugitive#statusline'
	\ },
\ }

:set ignorecase
:set smartcase

:set mouse=a

syntax on

colorscheme onedark
