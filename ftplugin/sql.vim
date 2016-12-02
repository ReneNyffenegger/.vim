call TQ84_log_indent(expand('<sfile>'))

nnoremap <buffer> <F3>      :let @+ = '@"'.expand('%:p').'"'<CR>:w<CR>
inoremap <buffer> <F3> <ESC>:let @+ = '@"'.expand('%:p').'"'<CR>:w<CR>

set foldmarker=\ {,\ }
set foldmethod=marker
set foldtext=getline(v:foldstart)
set commentstring=\ --%s

call TQ84_log_dedent()
