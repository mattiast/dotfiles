call plug#begin('~/.vim/plugged')

Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

Plug 'kien/ctrlp.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'roblillack/vim-bufferlist'
Plug 'godlygeek/tabular'

Plug 'neovimhaskell/haskell-vim'
Plug 'parsonsmatt/intero-neovim'
Plug 'eagletmt/neco-ghc'

Plug 'ElmCast/elm-vim'
Plug 'majutsushi/tagbar'
Plug 'pbogut/deoplete-elm'
Plug 'cstrahan/vim-capnp'
Plug 'benmills/vimux'

Plug 'idris-hackers/idris-vim'
call plug#end()

imap <C-k> <Plug>(neosnippet_expand_or_jump)
colorscheme inkpot

let mapleader = ","
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <silent> <leader>n :nohlsearch<CR>
nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>a :call BufferList()<cr>
nnoremap <silent> <leader>m :CtrlPMRUFiles<cr>
nnoremap <silent> <leader>f :CtrlP<cr>
nnoremap <silent> <leader>d :CtrlPDir<cr>
nnoremap <silent> <leader>g :TagbarToggle<cr>
nnoremap <silent> <leader>r :r! date<cr><cr>O<esc>O
nnoremap <leader>h :cd %:h<cr>
vnoremap <leader>s "*y
nnoremap <leader>p "*p
vnoremap <leader>S "+y
nnoremap <leader>P "+p
nnoremap <leader>c :%s///gn
vnoremap <leader>' :s/'/ä/g
vnoremap <leader>; :s/;/ö/g

nnoremap <silent> <leader>cs :Gstatus<cr>
nnoremap <silent> <leader>cd :Gdiff<cr>
nnoremap <silent> <leader>cc :Gcommit<cr>
vnoremap <leader>cg y:Ggrep <C-R>"
nnoremap <silent> <leader>ce :Gedit HEAD<cr>

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set wildignorecase
set ignorecase
set autowrite
set hidden
set mouse=a
set relativenumber
set diffopt=filler,vertical

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
imap <expr><TAB>
     \ neosnippet#expandable_or_jumpable() ?
     \    "\<Plug>(neosnippet_expand_or_jump)" :
     \    pumvisible() ? "\<C-n>" : "\<TAB>"

" let g:airline_powerline_fonts = 1
let g:airline_symbols_ascii = 1


highlight NeomakeWarning ctermfg=Red ctermbg=Yellow
highlight NeomakeError ctermfg=White ctermbg=Red

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

let g:ledger_bin="hledger"

let g:neomake_idris_enabled_makers = [ 'idris' ]
let g:neomake_python_enabled_makers = [ 'flake8' ]
let g:intero_start_immediately = 0
