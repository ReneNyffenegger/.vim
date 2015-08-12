call TQ84_log_indent(expand("<sfile>"))

let b:in_tag = {}

fu! Switch_Tag(tag) " {
  call TQ84_log_indent(expand("<sfile>"))

  if ! has_key(b:in_tag, a:tag)
     let b:in_tag[a:tag] = 0
  endif

  if b:in_tag[a:tag]
     execute 'normal a</' . a:tag . '>'
     let b:in_tag[a:tag] = 0
  else
     execute 'normal a<'  . a:tag . '>'
     let b:in_tag[a:tag] = 1
  endif

  if col('.') + 1 == col('$')
     call TQ84_log(' . : ' . col('.') . ', $ : ' . col('$') . ' -> startinsert !')
     startinsert!
  else
    call TQ84_log(' . : ' . col('.') . ', $ : ' . col('$') . ' -> normal l , startinsert')
    execute 'normal l'
    startinsert
  end

  call TQ84_log_dedent()

endfu " }

inoremap <buffer> <M-i> <ESC>:call Switch_Tag('i')<CR>
inoremap <buffer> <M-b> <ESC>:call Switch_Tag('b')<CR>

vnoremap <buffer> <M-b> :call tq84#EmbedVisualSelection('<b>', '</b>')<CR>
vnoremap <buffer> <M-i> :call tq84#EmbedVisualSelection('<i>', '</i>')<CR>

call TQ84_log_dedent()
