" setlocal omnifunc=necoghc#omnifunc
let g:necoghc_use_stack = 1

map <silent> <leader>tt <Plug>InteroGenericType
map <silent> <leader>tg <Plug>InteroType
map <silent> <leader>tr :InteroReload<cr>
map <silent> <leader>tl :InteroLoadCurrentModule<cr>
map <silent> <leader>to :InteroOpen<cr>
map <silent> <leader>th :InteroHide<cr>
map <silent> <leader>ti :InteroInfo<cr>
map <leader>tc :!echo ":ctags" \| stack ghci<cr>

let g:haskellmode_completion_ghc = 0
