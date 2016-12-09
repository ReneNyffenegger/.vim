call TQ84_log_indent(expand('<sfile>'))

fu! tq84#buf#logLineAndPos() " {
  call TQ84_log_indent('tq84#buf#logLineAndPos')
  
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

fu! tq84#buf#wordLeftOfCursor() " {
   call TQ84_log_indent('tq84#buf#wordLeftOfCursor')

   call tq84#buf#logLineAndPos()

   let l:line= getline('.')
   let l:col = col    ('.')

   let l:word = matchstr  (l:line,    '\<\w\+\%' . l:col . 'c')

   call TQ84_log('returning word left of cursor=' . l:word)

   call TQ84_log_dedent()
   return l:word
endfu " }

fu! tq84#buf#insertRightOfCursor(text) " {
   call TQ84_log_indent('tq84#buf#insertRightOfCursor, text=' . a:text . '<')

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
    call TQ84_log_indent('tq84#buf#insertLines')
    let l:lines = map(a:lines, 'printf("%' . a:indent . 's%s", "", v:val)')

    call append(line('.'), l:lines)
    call TQ84_log_dedent()
endfu " }

fu! tq84#buf#buffers() " {
    let l:ret=[]
    call TQ84_log_indent(expand('<sfile>'))

    for l:bufNr in range(1, bufnr('$'))

        if bufexists(l:bufNr)
           let l:bufName = bufname(l:bufNr)
           call TQ84_log('Adding ' . l:bufName . ' (' . l:bufNr . ')')
           call add(l:ret, l:bufName)
        else
           call TQ84_log('buffer ' . l:bufNr . ' does not exist')
        endif

    endfor

    call TQ84_log_dedent()

    return l:ret
endfu " }

fu! tq84#buf#openFile(filename) " {
    call TQ84_log_indent(expand('<sfile>'))
  
    let l:curr_name = substitute(expand('%:p'), '\', '/', 'g')
    let l:file_name = substitute(a:filename   , '\', '/', 'g')
  
    call TQ84_log('l:curr_name = ' . l:curr_name)
    call TQ84_log('l:file_name = ' . l:file_name)
  
    if l:curr_name  ==? l:file_name
       call TQ84_log('Current buffer is already file looked for')
       call TQ84_log_dedent()
       return 0
    endif
  
    let l:winNr = bufwinnr(a:filename)
  
    call TQ84_log('Window nr for requested file: ' . l:winNr)
  
    if l:winNr != -1
       exe l:winNr . 'wincmd w'
       call TQ84_log_dedent()
  
     " Return 0 to indicate that window was not split
       return 0
    endif
  
    let l:curWin = winbufnr(0)
    call TQ84_log('current window: ' . l:curWin)
  
    let l:curBufName = bufname(l:curWin)
    call TQ84_log('current buffer name ' . l:curBufName)
  
    let l:new_split = 0
    if l:curBufName != ""
        call TQ84_log('opening new window')
  
        split
        let l:new_split = 1
    end
  
    call TQ84_log('e ' . a:filename)
    execute "e " . a:filename
  
    call TQ84_log_dedent()
    return l:new_split
endfu " }


call TQ84_log_dedent()
