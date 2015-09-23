call TQ84_log_indent(expand("<sfile>"))

let b:in_tag = {}

fu! <SID>Switch_Tag(tag) " {
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

  return ''

endfu " }
fu! <SID>RemoveComment() " {

  execute "normal i" . nr2char(10000)

  call search('<!--', 'b')
  normal 4x
  call search('-->')
  normal 3x
  call search(nr2char(10000), 'b')
  normal x

endfu " }
fu! <SID>LinkFromClipbaord() " {
  call TQ84_log_indent(expand('<sfile>'))

  if getreg('*') =~? '\v^https?://'  " {
  
     execute 'normal a<a href="' . getreg('*') . '">' . getreg('*') . '</a> '
     startinsert

     call TQ84_log('Link ' . getreg('*') . ' was inserted')

     call TQ84_log_dedent()
     return

  endif " }

  call TQ84_log_dedent()
endfu " }
fu! <SID>GotoID() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:id = expand('<cword>')
  call TQ84_log('l:id = ' . l:id)

  call search('id=["'']' . l:id . '["'']')

  call TQ84_log_dedent()
endfu " }

inoremap <buffer> <M-i> =<SID>Switch_Tag('i')<CR>
inoremap <buffer> <M-b> =<SID>Switch_Tag('b')<CR>

nnoremap <buffer> ,rmcom <ESC>:call <SID>RemoveComment()<CR>
vnoremap <buffer> ,com  :call tq84#EmbedVisualSelection('<!-- ', ' -->')<CR>

vnoremap <buffer> <M-b> :call tq84#EmbedVisualSelection('<b>', '</b>')<CR>
vnoremap <buffer> <M-i> :call tq84#EmbedVisualSelection('<i>', '</i>')<CR>
vnoremap <buffer> ,em   :call tq84#EmbedVisualSelection('<em>', '</em>')<CR>

" Visually select between last > and following <
nnoremap <buffer> ,vi<  v?>lo/<h
nnoremap <buffer> ,ci<  v?>lo/<hc

nnoremap <buffer> <leader>gtid  :call <SID>GotoID()<CR>

nnoremap <buffer> <leader><Space> c &nbsp;<ESC>


" Create a <a href link with the content of the clipboard
inoremap <buffer> ,a <ESC>:call <SID>LinkFromClipbaord()<CR>

call TQ84_log_dedent()
