call TQ84_log_indent(expand('<sfile>'))

nnoremap <buffer> ! :call tq84#SystemInDir(expand('%:p:h'), 'c:\tools\graphviz-2.38\release\bin\dot.exe -Gcharset=utf8 -Tpdf -o' . expand('%:t:r') . '.pdf ' . expand('%:t') . ' & ' . expand('%:t:r') . '.pdf')<CR>

call TQ84_log_dedent()
