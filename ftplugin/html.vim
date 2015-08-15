call TQ84_log_indent(expand("<sfile>"))

let b:in_tag = {}

fu! Switch_Tag(tag) " {
  call TQ84_log_indent(expand("<sfile>"))

  if ! has_key(b:in_tag, a:tag)
     let b:in_tag[a:tag] = 0
  endif

  if b:in_tag[a:tag]
     call GUI#InsertModeInsertText('</' . a:tag . '>')
     let b:in_tag[a:tag] = 0
  else
     call GUI#InsertModeInsertText('<'  . a:tag . '>')
     let b:in_tag[a:tag] = 1
  endif

  call TQ84_log_dedent()

endfu " }

inoremap <buffer> <M-i> <ESC>:call Switch_Tag('i')<CR>
inoremap <buffer> <M-b> <ESC>:call Switch_Tag('b')<CR>

vnoremap <buffer> <M-b> :call tq84#EmbedVisualSelection('<b>', '</b>')<CR>
vnoremap <buffer> <M-i> :call tq84#EmbedVisualSelection('<i>', '</i>')<CR>

call TQ84_log_dedent()
