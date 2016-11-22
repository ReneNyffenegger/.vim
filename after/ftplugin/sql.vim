call TQ84_log_indent(expand('<sfile>'))

map <buffer> <F3> :let @+ = '@"'.expand('%:p').'"'<CR>

call TQ84_log_dedent()
