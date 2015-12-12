call TQ84_log_indent(expand('<sfile>'))

set foldmarker={,}
set foldmethod=marker
set foldtext=getline(v:foldstart)

fu! <SID>Today() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:y = strftime('%Y')
  let l:m = strftime('%m')
  let l:d = strftime('%d')

  call TQ84_log('y=' . l:y . ', m=' . l:m . ', d=' . l:d)

  call TQ84_log_dedent()
  return {'y': l:y, 'm': l:m, 'd': l:d}
endfu " }

fu! <SID>StatusLine() " {
" call TQ84_log_indent(expand('<sfile>'))

  let l:pos_cursor=getpos('.')
  
  let l:lineDay  =search('\v^ *\d\d (Mo|Di|Mi|Do|Fr|Sa|So)>', 'b')
  let l:lineMonth=search('\v^ *\d\d \' . nr2char(123)       , 'b') " 123 is opening curly braces
  let l:lineYear =search('\v^ *\d\d\d\d \' . nr2char(123)   , 'b')

" call TQ84_log('l:lineDay =' . l:lineDay) 

  let l:DayText  =getline(l:lineDay  )
  let l:MonthText=getline(l:lineMonth)
  let l:YearText =getline(l:lineYear )

  let l:DayNr    =substitute(l:DayText  , '\v(\d\d).*'    , '\1', '')
  let l:DayName  =substitute(l:DayText  , '\v\d\d (..).*' , '\1', '')
  let l:MonthText=substitute(l:MonthText, '\v(\d\d).*'    , '\1', '')
  let l:YearText =substitute(l:YearText , '\v(\d\d\d\d).*', '\1', '')

  let l:date = l:YearText . '-' . l:MonthText . '-' . l:DayNr . ' (' . l:DayName . ')'

" call TQ84_log('l:DayText=' . l:DayText) 

  call setpos('.', l:pos_cursor)

" call TQ84_log_dedent()
  return l:date

endfu " }

fu! s:SID() " {
  call TQ84_log_indent(expand('<sfile>'))
  let s:SID=matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
  call TQ84_log('s:SID=' . s:SID)
  call TQ84_log_dedent()
  return s:SID
endfu " }

fu! AgendaGoToToday() " {

  call AgendaGoToDate(<SID>Today())

endfu " }

fu! AgendaGoToDate(date) " {

  call TQ84_log_indent(expand('<sfile>') . ' y=' . a:date['y'] . ', m=' . a:date['m'] . ', d=' . a:date['d'])

  call TQ84_log('len(date[m]): ' . len(a:date['m']))
  if len(a:date['m']) == 1
     let l:m = printf('%02d', a:date['m'])
     call TQ84_log('a:date[m] converted to ' . l:m)
  else
     let l:m = a:date['m']
  endif

  call TQ84_log('len(a[d]): ' . len(a:date['d']))
  if len(a:date['d']) == 1
     let l:d = printf('%02d', a:date['d'])
     call TQ84_log('a:date[d] converted to ' . l:d)
  else
     let l:d = a:date['d']
  endif

  if ! search('^' . a:date['y'] . ' ' . nr2char(123))
     call TQ84_log('Year ' . l:date['y'] . ' not found')
     call TQ84_log_dedent()
     return
  endif

  if ! search('^' . l:m . ' ' . nr2char(123))
     call TQ84_log('Month ' . l:m . ' not found')
     call TQ84_log_dedent()
     return
  endif

  if ! search('\v^' . l:d . ' (Mo|Di|Mi|Do|Fr|Sa|So)>.*\' . nr2char(123))
     call TQ84_log('Day ' . l:d . ' not found')
     call TQ84_log_dedent()
     return
  endif

  normal zo
  normal zo
  normal zo

  call TQ84_log_dedent()

endfu " }

fu! AgendaGoToDateWithInput() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:dateInput = input('Date: ')

  let l:year  = substitute(l:dateInput, '\v(\d\d\d\d).*'        , '\1','')
  let l:month = substitute(l:dateInput, '\v\d\d\d\d (\d+).*'   , '\1','')
  let l:day   = substitute(l:dateInput, '\v\d\d\d\d \d+ (\d+)', '\1','')

  call TQ84_log('l:dateInput: ' . l:dateInput . ', l:year=' . l:year . ', l:month=' . l:month . ', l:day=' . l:day)

  normal zC

  call AgendaGoToDate({'y': l:year, 'm': l:month, 'd': l:day})

  call TQ84_log_dedent()
endfu " }

fu! AgendaGoToNextWeekday(weekday) " {
  call TQ84_log_indent(expand('<sfile>'))

  call AgendaGoToToday()

  call search('^\d\d ' . a:weekday . '\>')
  normal zo

  call TQ84_log_dedent()
endfu " }

execute "setl statusline=%!<SNR>" . s:SID() . '_StatusLine()'

nnoremap <buffer> ,gtd <ESC>:call AgendaGoToDateWithInput()<CR>
nnoremap <buffer> ,gtt <ESC>:call AgendaGoToToday()<CR>

nnoremap <buffer> ,gtnmo <ESC>:call AgendaGoToNextWeekday('Mo')<CR>
nnoremap <buffer> ,gtndi <ESC>:call AgendaGoToNextWeekday('Di')<CR>
nnoremap <buffer> ,gtnmi <ESC>:call AgendaGoToNextWeekday('Mi')<CR>
nnoremap <buffer> ,gtndo <ESC>:call AgendaGoToNextWeekday('Do')<CR>
nnoremap <buffer> ,gtnfr <ESC>:call AgendaGoToNextWeekday('Fr')<CR>
nnoremap <buffer> ,gtnsa <ESC>:call AgendaGoToNextWeekday('Sa')<CR>
nnoremap <buffer> ,gtnso <ESC>:call AgendaGoToNextWeekday('So')<CR>

call AgendaGoToToday()

call TQ84_log_dedent()
