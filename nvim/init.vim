call plug#begin('~/.vim/plugged')

Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'

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
nnoremap <silent> <leader>r :r! date<cr><cr>O<esc>O
nnoremap <leader>h :cd %:h<cr>
vnoremap <leader>s "*y
nnoremap <leader>p "*p
vnoremap <leader>' :s/'/ä/g
vnoremap <leader>; :s/;/ö/g
call plug#end()

nnoremap <silent> <leader>cs :Gstatus<cr>
nnoremap <silent> <leader>cd :Gdiff<cr>
nnoremap <silent> <leader>cc :Gcommit<cr>
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
imap <expr><TAB>
	 \ neosnippet#expandable_or_jumpable() ?
	 \    "\<Plug>(neosnippet_expand_or_jump)" :
     \ 	  pumvisible() ? "\<C-n>" : "\<TAB>"

" let g:airline_powerline_fonts = 1 
let g:airline_symbols_ascii = 1


highlight NeomakeWarning ctermfg=54 ctermbg=148
highlight NeomakeError ctermfg=154 ctermbg=126

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

let g:ledger_bin="hledger"
