call TQ84_log_indent(expand('<sfile>'))

fu tq84#buf#logLineAndPos() " {
  call TQ84_log_indent(expand('<sfile>'))
  
  let l:line_intro = 'line (' . line('.') . ') >'

  call TQ84_log(l:line_intro . getline(line('.')) . '<')

  let l:show_virt_col = repeat(' ', strlen(l:line_intro))

  for i in range(1, virtcol('$'))
      if     i == virtcol('.') && i == virtcol('$')
             let l:show_virt_col = l:show_virt_col . '#'
      elseif i == virtcol('.')
             let l:show_virt_col = l:show_virt_col . '^'
      elseif i == virtcol('$')
             let l:show_virt_col = l:show_virt_col . '$'
      else
             let l:show_virt_col = l:show_virt_col . ' '
      endif
  endfor

  call TQ84_log(l:show_virt_col)
  call TQ84_log_dedent()
endfu " }

fu tq84#buf#wordLeftOfCursor() " {
   call TQ84_log_indent(expand('<sfile>'))

   call tq84#buf#logLineAndPos()

   let l:line= getline('.')
   let l:col = col    ('.')

   let l:word = matchstr  (l:line,    '\<\w\+\%' . l:col . 'c')

   call TQ84_log('returning word left of cursor=' . l:word)

   call TQ84_log_dedent()
   return l:word
endfu " }

fu! tq84#buf#insertRightOfCursor(text) " {
   call TQ84_log_indent(expand('<sfile>') . ', text=' . a:text . '<')

   let l:last_column = virtcol('.')  == virtcol('$')
   call tq84#buf#logLineAndPos()

   let l:col =col    ('.')
   let l:line=getline('.')

   if l:last_column
      call TQ84_log('is last col')
      let l:line=substitute(l:line, '$'                    , a:text . '\1', '')
   else
      call TQ84_log('is not last col')
      let l:line=substitute(l:line, '\%' . l:col . 'c\(.\)', a:text . '\1', '')
   endif

   call TQ84_log('line=' . l:line)
   call setline(line('.'), l:line)

   call TQ84_log_dedent()
endfu " }

fu! tq84#buf#insertLines(lines, indent) " {
    call TQ84_log_indent(expand('<sfile>'))
    let l:lines = map(a:lines, 'printf("%' . a:indent . 's%s", "", v:val)')

    call append(line('.'), l:lines)
    call TQ84_log_dedent()
endfu " }


call TQ84_log_dedent()