call TQ84_log_indent(expand('<sfile>'))

let b:instructions = []

fu <SID>TabPressed() " {
   call TQ84_log_indent(expand('<sfile>'))

   let l:wordLeftOfCursor = <SID>WordLeftOfCursor()
   call TQ84_log('wordLeftOfCursor=' . l:wordLeftOfCursor . '<')

   if     l:wordLeftOfCursor == 'if' " {

          let l:mark1 = tq84#tabber2#nextJumpToMark()
          let l:mark2 = tq84#tabber2#nextJumpToMark()

          call add(b:instructions, function('tq84#tabber2#jumpToMarkAndEatIt', [l:mark2]))
          call add(b:instructions, function('tq84#tabber2#jumpToMarkAndEatIt', [l:mark1]))

          call <SID>InsertRightOfCursor(' " {')

          let l:lines = ['   ' . l:mark1 . ' foo', 'endif " }', l:mark2]

          call <SID>InsertLines(l:lines, col('.')-1 - len(l:wordLeftOfCursor)) 

          call TQ84_log_dedent()
          return ' '
   endif " }

   if len(b:instructions) " {

      call TQ84_log('len(b:instructions) = ' . len(b:instructions))
      let l:Instruction = remove(b:instructions, -1)
      call TQ84_log('calling ' . string(l:Instruction))
      let l:ret = l:Instruction()
      call TQ84_log('l:ret = ' . l:ret . '<')
      call TQ84_log_dedent()
      return l:ret

   endif " }


   call TQ84_log_dedent()

   return nr2char(9)
endfu " }

call tq84#tabber2#init(function('<SID>TabPressed'))


fu <SID>WordLeftOfCursor() " {
   call TQ84_log_indent(expand('<sfile>'))

   let l:line=getline('.')

   let l:col = col('.')

   let l:word = matchstr  (l:line,    '\<\w\+\%' . l:col . 'c')

   call TQ84_log('l:word=' . l:word)

   call TQ84_log_dedent()
   return l:word
endfu " }

fu <SID>InsertRightOfCursor(text) " {
   call TQ84_log_indent(expand('<sfile>') . ', text=' . a:text . '<')

   let l:last_column = virtcol('.')  == virtcol('$')
   call <SID>LogLineAndPos()

   let l:col=col('.')
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

fu <SID>InsertLines(lines, indent) " {
   call TQ84_log_indent(expand('<sfile>'))
   let l:lines = map(a:lines, 'printf("%' . a:indent . 's%s", "", v:val)')

   call append(line('.'), l:lines)
   call TQ84_log_dedent()
endfu " }

fu! <SID>LogLineAndPos() " {
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

call TQ84_log_dedent()
