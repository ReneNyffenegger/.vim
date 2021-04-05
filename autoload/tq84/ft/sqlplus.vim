call TQ84_log_indent(expand('<sfile>'))

fu! tq84#ft#sqlplus#mappings() " {

   call TQ84_log_indent('tq84#ft#perl#sqlplus#mapping ' . expand('%'))

   nnoremap <buffer> <F3>      :let @+ = '@"'.expand('%:p').'"'.nr2char(10)<CR>:w<CR>
   inoremap <buffer> <F3> <ESC>:let @+ = '@"'.expand('%:p').'"'.nr2char(10)<CR>:w<CR>

   call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
