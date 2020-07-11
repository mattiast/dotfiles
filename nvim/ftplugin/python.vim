setlocal foldmethod=indent
setlocal foldnestmax=1
setlocal foldminlines=4

command! Imps :!isort %:p
command! Black :!black %:p
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <leader>tt :call CocAction("doHover")<cr>
nmap <silent> <leader>ta :CocAction<cr>
nmap <silent> <leader>to :CocList outline<cr>
