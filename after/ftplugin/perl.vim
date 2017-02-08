call TQ84_log_indent(expand('<sfile>'))

" 2017-02-08
" setl commentstring=\ \#\ %s
setl commentstring=\ #%s

setl foldmethod=marker
setl foldtext=getline(v:foldstart)

" 2017-02-08
" setl foldmarker=\ {,\ }
setl foldmarker=_{,_}

call TQ84_log_dedent()
