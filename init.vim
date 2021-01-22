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
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'
Plug 'liuchengxu/vim-which-key'
Plug 'sheerun/vim-polyglot'
call plug#end()

map <SPACE> <leader>
nmap <leader>fw :w!<cr>

nmap <leader>pf :FZF<cr>
nmap <leader>pp :FZF<cr>

nmap <leader>w <C-w>
nmap <C-w>w :W<cr>
nmap <leader>sf :BLines<cr>
nmap <leader>ss /
nmap <leader>sp :Rg<cr>

nmap <leader>op :NERDTreeToggle<cr>
nmap <leader>of :!open %:p:h<cr>
nmap <leader>ot :let $VIM_DIR=expand('%:p:h')<cr>:term<cr>icd $VIM_DIR<cr>

nmap <leader>cd :call CocActionAsync('jumpDefinition')<cr>
nmap <leader>cD <Plug>(coc-references)

nmap <leader>gg :Gstatus<cr>

nmap <silent><leader>bb :Buffers<cr>
nmap <silent><leader>bk :bd<cr>
nmap <silent><leader>bc :bd<cr>

nnoremap <silent><TAB> :bnext<cr>

"nnoremap <silent><leader> :WhichKey '<Space>'<CR>

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

let g:ascii = [
\ '  , _            _                     ',
\ ' /|/ \          (_|   |_/o             ',
\ '  |   |   _   __  |   |      _  _  _   ',
\ '  |   |  |/  /  \_|   |  |  / |/ |/ |  ',
\ '  |   |_/|__/\__/  \_/   |_/  |  |  |_/',
\ ''
\]

"let g:startify_custom_header = g:ascii + startify#fortune#quote()
let g:startify_custom_header = g:ascii
let g:startify_change_to_vcs_root = 1

function! s:switchDirAndShowFiles(path)
	lcd path
	execute FZF path
endfunction

function! s:zFrecentFolders()
    let files = systemlist("z | tail -n 10 | awk '{print $2}' 2>/dev/null")
    return map(files, "{'line': v:val, 'path': v:val}") 
endfunction
" , 'cmd': 'function(s:switchDirAndShowFiles('.v:val.'))'}")

let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Files in '. getcwd()] },
        \ { 'type': function('s:zFrecentFolders'),  'header': ['   Recent directories']},
        \ { 'type': 'files',     'header': ['   Other files']            }
\ ]

set nowrap
set number

set ignorecase
set smartcase

set mouse=a


set termguicolors

if (has("autocmd") && !has("gui_running"))
  augroup colors
    autocmd!
    let s:foreground = { "gui": "#bdbacc", "cterm": "235", "cterm16": "0" }
    let s:background = { "gui": "#1e2129", "cterm": "235", "cterm16": "0" }
    autocmd ColorScheme * call onedark#extend_highlight("Normal", { "bg": s:background, "fg": s:foreground })
    "autocmd ColorScheme * call onedark#extend_highlight("Normal", { "bg": s:background }) "No `fg` setting
  augroup END
endif

let g:onedark_terminal_italics = 1
colorscheme onedark

syntax on
