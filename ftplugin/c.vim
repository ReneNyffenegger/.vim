call TQ84_log_indent('ftplugin/c.vim')

:map <buffer> ! :!gcc % -o /tmp/a.out && /tmp/a.out<CR>

setlocal foldmethod=marker
setlocal foldmarker=\ //\ {,\ //\ }
setlocal commentstring=%s
setlocal ai

call TQ84_log_dedent()
