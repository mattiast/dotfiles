call plug#begin('~/.vim/plugged')

Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

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
Plug 'ElmCast/elm-vim'
Plug 'majutsushi/tagbar'
Plug 'pbogut/deoplete-elm'
Plug 'cstrahan/vim-capnp'
Plug 'benmills/vimux'
Plug 'hwayne/tla.vim'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'airblade/vim-gitgutter'
Plug 'zchee/deoplete-jedi'

Plug 'idris-hackers/idris-vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'LnL7/vim-nix'
Plug 'tpope/vim-unimpaired'
call plug#end()

imap <C-k> <Plug>(neosnippet_expand_or_jump)
colorscheme inkpot

let mapleader = ","
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <silent> <leader>n :nohlsearch<CR>
nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>a :call BufferList()<cr>
nnoremap <silent> <leader>mm :CtrlPMRUFiles<cr>
nnoremap <silent> <leader>mf :CtrlP<cr>
nnoremap <silent> <leader>mt :CtrlPTag<cr>
nnoremap <silent> <leader>mr :CtrlPBufTagAll<cr>
nnoremap <silent> <leader>g :TagbarToggle<cr>
nnoremap <silent> <leader>r :r! date<cr><cr>O<esc>O
nnoremap <leader>h :cd %:h<cr>
vnoremap <leader>s "*y
nnoremap <leader>p "*p
vnoremap <leader>S "+y
nnoremap <leader>P "+p
nnoremap <leader>C :%s///gn<cr>

nnoremap <silent> <leader>cs :Gstatus<cr>
nnoremap <silent> <leader>cd :Gdiff<cr>
nnoremap <silent> <leader>cc :Gcommit<cr>
vnoremap <leader>cg y:Ggrep <C-R>"
nnoremap <leader>cg yiw:Ggrep "\<<C-R>"\>"
nnoremap <leader>cv :copen<cr>
nnoremap <silent> <leader>ce :Gedit HEAD<cr>

function! FixAO() range
  silent! execute a:firstline . "," . a:lastline . "s/'/ä/g"
  silent! execute a:firstline . "," . a:lastline . "s/;/ö/g"
endfunction
vnoremap <leader>; :call FixAO()<cr>

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set wildignorecase
set ignorecase
set autowrite
set hidden
set mouse=a
set relativenumber
set diffopt=filler,vertical
set updatetime=100

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1

let g:airline_symbols_ascii = 1

let g:ctrlp_working_path_mode = 'a'

let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_elm_enabled_makers = ['elmMake']

let g:neomake_python_enabled_makers = ['flake8', 'mypy']
let g:neomake_python_mypy_args = neomake#makers#ft#python#mypy().args + ['--python-version', '3.7']
let g:neomake_idris_enabled_makers = ['idris']
highlight NeomakeWarning ctermfg=Red ctermbg=Yellow
highlight NeomakeError ctermfg=White ctermbg=Red
highlight ALEWarning ctermfg=Red ctermbg=Yellow
highlight ALEError ctermfg=White ctermbg=Red

let g:intero_start_immediately = 0
" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

let g:ledger_bin="hledger"
let g:markdown_folding = 1

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
    \ }
