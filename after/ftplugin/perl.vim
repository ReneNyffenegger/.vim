call TQ84_log_indent(expand('<sfile>'))

setl commentstring=\ \#%s

setl foldmethod=marker
setl foldtext=getline(v:foldstart)
setl foldmarker=\ {,\ }

call TQ84_log_dedent()
