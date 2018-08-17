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

fu! tq84#buf#regexpAtCursor(regexp) " { # Note that regexp should be very magic (as though \v was prepended)
   call TQ84_log_indent('tq84#buf#regexpAtCursor, regexp = ' . a:regexp)

   call tq84#buf#logLineAndPos()

   let l:line = getline('.')
   let l:pos  = virtcol('.')

   let l:pos_1 = l:pos + 1
   let l:pos_2 = l:pos
   if l:pos_2 < 0
      let l:pos_2 = 0
   endif

   let l:regexp = 
   \ '\v'                .
   \ '%<'  .  l:pos_1    . 'v' .
   \          a:regexp   .     
   \ '%>'  .  l:pos_2    . 'v'

   let l:matched = matchstr(l:line, l:regexp)
   call TQ84_log('l:matched=' . l:matched)

   call TQ84_log_dedent()
   return l:matched
endfu " }

fu! tq84#buf#lineRightOfCursor() " {
   call TQ84_log_indent('tq84#buf#lineLeftOfCursor')

   call tq84#buf#logLineAndPos()

   let l:line= getline('.')
   let l:col = col    ('.')

   let l:line_ = strpart(l:line, l:col-1)

   call TQ84_log('returning line right of cursor=' . l:line_)

   call TQ84_log_dedent()
   return l:line_
endfu " }

fu! tq84#buf#lineLeftOfCursor() " {
   call TQ84_log_indent('tq84#buf#lineLeftOfCursor')

   call tq84#buf#logLineAndPos()

   let l:line= getline('.')
   let l:col = col    ('.')

   let l:line_ = strpart(l:line, 0, l:col-1)

   call TQ84_log('returning line right of cursor=' . l:line_)

   call TQ84_log_dedent()
   return l:line_
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
"
"   Returns
"      0 if the buffer was already existing
"      1 if the buffer was created
"
    call TQ84_log_indent(expand('<sfile>'))
  
    let l:curr_name = substitute(expand('%:p'), '\', '/', 'g')
    let l:file_name = substitute(a:filename   , '\', '/', 'g')
  
    call TQ84_log('l:curr_name = ' . l:curr_name)
    call TQ84_log('l:file_name = ' . l:file_name)
  
    if l:curr_name  ==? l:file_name
       call TQ84_log('Current buffer is already file looked for, returning 0')
       call TQ84_log_dedent()
       return 0
    endif
  
    let l:winNr = bufwinnr(a:filename)
  
    call TQ84_log('Window nr for requested file: ' . l:winNr)
  
    if l:winNr != -1
       exe l:winNr . 'wincmd w'

       call TQ84_log('Window with requested buffer already visible, jumping to window and returning 0')
       call TQ84_log_dedent()
  
       return 0
    endif
  
    let l:curWin = winbufnr(0)
    call TQ84_log('current window: ' . l:curWin)
  
    let l:curBufName = bufname(l:curWin)
    call TQ84_log('current buffer name ' . l:curBufName)
  
"   let l:new_split = 0
    if l:curBufName != ""
        call TQ84_log('opening new window, assigning 1 to l:new_split')
  
        split
"       let l:new_split = 1
    end

    if bufnr(a:filename) == -1
       let l:newBuffer = 1
    else
       let l:newBuffer = 0
    endif
  
    call TQ84_log('e ' . a:filename)
    execute "e " . a:filename
  
    call TQ84_log('returning l:newBuffer=' . l:newBuffer)
    call TQ84_log_dedent()
    return l:newBuffer
endfu " }

fu! tq84#buf#openScratch(name) " {
    call TQ84_log_indent('tq84#buf#openScratch, name = ' . a:name)

    let l:newBuffer = tq84#buf#openFile(a:name)

    if l:newBuffer " {
       call TQ84_log('l:newBuffer != 0, setting buftype etc')
       setl buftype=nofile  " Don't related buffer with any phsyical file
       setl bufhidden=hide  " Don't unload the buffer when buffer is no longer displayed in window
       setl noswapfile
       setl nobuflisted     " Don't show bufer in buffer list
    endif " }

    call TQ84_log_dedent()
endfu " }

fu! tq84#buf#set_ff_unix_rm_trailing_space() " {
 "
 "  2018-08-17: currently assigned shortcut key is: Ctrl-F5
 "
    call TQ84_log_indent('tq84#buf#set_ff_unix_rm_trailing_space')

    set ff=unix
    silent %s/\t/  /ge
    silent %s/  *$//e
    silent w

    call TQ84_log_dedent()
endfu

call TQ84_log_dedent()
