call TQ84_log_indent('vimfiles/ftplugin/r.vim')

map <buffer> ! :call tq84#SystemInDir(expand('%:h'), 'r -f ' . expand('%:t'))<CR>

call TQ84_log_dedent()
