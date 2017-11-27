call TQ84_log_indent(expand("<sfile>"))


" Mappings where the registry hack
" cannot be used due to lacking
" administrator rights

" noremap  <M-w> <C-w>

inoremap <M-d> <C-d>
inoremap <M-r> <C-r>
inoremap <M-v> <C-v>
inoremap <M-w> <C-w>
inoremap <M-x> <C-x>

cnoremap <M-r> <C-r>
cnoremap <M-w> <C-w>
cnoremap <M-v> <C-v>

nnoremap <M-d> <C-f>
nnoremap <M-e> <C-e>
nnoremap <M-f> <C-f>
nnoremap <M-r> <C-r>
nnoremap <M-v> <C-v>
nnoremap <M-w> <C-w>
nnoremap <M-y> <C-y>
nnoremap g<M-g> g<C-g>

vnoremap <M-v> <C-v>

xnoremap <M-e> <C-e>
xnoremap <M-y> <C-y>
xnoremap <M-x> <C-x>

call TQ84_log_dedent()
