call TQ84_log_indent(expand('<sfile>') . ': ' . expand('<slnum>'))

fu! Buffer#InsertLines(lines, ...) " {

    call TQ84_log_indent(expand('<sfile>') . ': ' . expand('<slnum>') . ' - len(a:000): ' . len(a:000))

    if len(a:000) > 1 " {
       call TQ84_log('at most one otional argument expected!')
       call TQ84_log_dedent()
       throw expand('<sfile>') . ': ' . expand('<slnum>') . ': At most one optional argument expected'

    endif " }

    if len(a:000) == 1  " { 

       if type(a:1) != 4 " { Check of optional parameter is a dictionary
       call TQ84_log('optional parameter must be a dictionary')
       call TQ84_log_dedent()
       throw expand('<sfile>') . ': ' . expand('<slnum>') . ': optional parameter must be a dictionary'
       endif  " }

       let l:opts = a:1

    " }
    else " {

       let l:opts ={}

    endif " }


    let l:firstLineNo = get(l:opts, 'firstLineNo', line('.'))
    let l:indent      = get(l:opts, 'indent'     ,       0  )

    let l:indentText  = repeat(' ', l:indent)

    call TQ84_log('firstLineNo=' . l:firstLineNo . ', indent=' . l:indent)

    let l:firstLineText = getline(l:firstLineNo)

    if l:firstLineText !~# '^\s*$' " { Cursor is on a non whitespace-only line.
       call TQ84_log('insert extra line')
       let l:firstLineNo = l:firstLineNo + 1
       normal 0o
    endif " }

    execute "normal " . (len(a:lines)-1) . 'o' . nr2char(27)

    for l in range(0, len(a:lines)-1) " {
    "
    "   2016-11-20: TODO Using »call append(...)« is probably easier
    "
        call TQ84_log('setting line ' . (l:firstLineNo+l) . ' to ' . a:lines[l])
        call setline(l:firstLineNo+l, l:indentText . a:lines[l])
    endfor " }
    
    call TQ84_log_dedent()
endfu " }

fu! Buffer#OpenFile(filename) " {
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
