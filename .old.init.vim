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
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'
Plug 'liuchengxu/vim-which-key'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'rakr/vim-one'

" Auto-complete with nvim cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

map <SPACE> <leader>
nmap <leader>fw :w!<cr>

nmap <leader>pf :FZF<cr>
nmap <leader>pp :NERDTreeToggle<cr>

nmap <leader>w <C-w>
nmap <C-w>w :W<cr>
nmap <leader>sf :BLines<cr>
nmap <leader>ss /
nmap <leader>sp :Rg<cr>

nmap <leader>of :!open %:p:h<cr>
nmap <leader>ot :let $VIM_DIR=expand('%:p:h')<cr>:term<cr>icd $VIM_DIR<cr>

nmap <leader>cd :call CocActionAsync('jumpDefinition')<cr>
nmap <leader>cD <Plug>(coc-references)

nmap <leader>gg :Git<cr>

nmap <silent><leader>bb :Buffers<cr>
nmap <silent><leader>bk :bd<cr>
nmap <silent><leader>bc :bd<cr>

nnoremap <silent><TAB> :bnext<cr>

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

"nnoremap <silent><leader> :WhichKey '<Space>'<CR>

let g:lightline = {
	\ 'colorscheme': 'one',
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

" IndentLine {{
let g:indentLine_char = '▏'
let g:indentLine_first_char = '▏'
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_setColors = 1
let g:indentLine_color_gui = '#2f2f36'
" }}

set termguicolors

let g:one_allow_italics = 1
colorscheme one
" set background=light " for the dark version

syntax on

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
EOF
