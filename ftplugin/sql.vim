call TQ84_log_indent(expand('<sfile>'))

nnoremap <buffer> <F3>      :let @+ = '@"'.expand('%:p').'"'<CR>:w<CR>
inoremap <buffer> <F3> <ESC>:let @+ = '@"'.expand('%:p').'"'<CR>:w<CR>

set foldmarker=\ {,\ }
set foldmethod=marker
set foldtext=getline(v:foldstart)
set commentstring=\ --%s

" Add clipboard's content below current cursor position with leading --
nnoremap <buffer> <F7> :call append('.', extend(map(extend([''], split(@+, "\n")), "'-- ' . v:val"), ['']))<CR>

call TQ84_log_dedent()
