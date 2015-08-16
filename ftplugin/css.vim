call TQ84_log_indent(expand("<sfile>"))

let b:in_tag = {}

fu! <SID>RemoveComment() " {

  execute "normal i" . nr2char(10000)

  call search('\/\*', 'b')
  normal 2x
  call search('\/\*')
  normal 2x
  call search(nr2char(10000), 'b')
  normal x

endfu " }

nnoremap <buffer> ,rmcom <ESC>:call <SID>RemoveComment()<CR>
vnoremap <buffer> ,com  :call tq84#EmbedVisualSelection('/* ', ' */')<CR>

call TQ84_log_dedent()
