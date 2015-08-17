call TQ84_log_indent(expand("<sfile>"))

let b:in_tag = {}

fu! <SID>RemoveComment() " {
  call TQ84_log_indent('<sfile>')


  execute "normal i" . nr2char(10000)

  call TQ84_log('line(.) = ' . line('.') . ' / virtcol(.) = ' . virtcol('.') . ' / virtcol($): ' . virtcol('$'))

  call search('\/\*', 'b')
  normal 2x
  call search('\*\/')
  normal 2x
  call search(nr2char(10000), 'b')
  normal x

  call TQ84_log_dedent()

endfu " }

nnoremap <buffer> ,rmcom <ESC>:call <SID>RemoveComment()<CR>
vnoremap <buffer> ,com  :call tq84#EmbedVisualSelection('/* ', ' */')<CR>

call TQ84_log_dedent()
