call TQ84_log_indent(expand('<sfile>'))

nnoremap <buffer> <F3>      :let @+ = '@"'.expand('%:p').'"'<CR>:w<CR>
inoremap <buffer> <F3> <ESC>:let @+ = '@"'.expand('%:p').'"'<CR>:w<CR>

call TQ84_log_dedent()
