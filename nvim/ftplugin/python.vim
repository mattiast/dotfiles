autocmd BufWritePost <buffer> Neomake
setlocal foldmethod=indent
setlocal foldnestmax=1
setlocal foldminlines=4

command! Imps :!isort %:p
command! Black :!black %:p
