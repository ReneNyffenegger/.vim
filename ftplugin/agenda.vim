call TQ84_log_indent(expand('<sfile>'))

set foldmarker={,}
set foldmethod=marker
set foldtext=getline(v:foldstart)

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

  let l:j = strftime('%Y')
  let l:m = strftime('%m')
  let l:t = strftime('%d')

" echo l:j . ' ' . l:m . ' ' . l:t

  call AgendaGoToDate(l:j, l:m, l:t)

endfu " }

fu! AgendaGoToDate(y, m, t) " {

  call TQ84_log_indent(expand('<sfile>') . ' y=' . a:y . ', m=' . a:m . ', t=' . a:t)

  call TQ84_log('len(a:m): ' . len(a:m))
  if len(a:m) == 1
     let l:m = printf('%02d', a:m)
     call TQ84_log('a:m converted to ' . l:m)
  else
     let l:m = a:m
  endif

  call TQ84_log('len(a:t): ' . len(a:t))
  if len(a:t) == 1
     let l:t = printf('%02d', a:t)
     call TQ84_log('a:t converted to ' . l:t)
  else
     let l:t = a:t
  endif

  if ! search('^' . a:y . ' ' . nr2char(123))
     call TQ84_log('Year ' . l:y . ' not found')
     call TQ84_log_dedent()
     return
  endif

  if ! search('^' . l:m . ' ' . nr2char(123))
     call TQ84_log('Month ' . l:m . ' not found')
     call TQ84_log_dedent()
     return
  endif

  if ! search('\v^' . l:t . ' (Mo|Di|Mi|Do|Fr|Sa|So)>.*\' . nr2char(123))
     call TQ84_log('Day ' . l:t . ' not found')
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

  call AgendaGoToDate(l:year, l:month, l:day)

  call TQ84_log_dedent()
endfu " }

execute "setl statusline=%!<SNR>" . s:SID() . '_StatusLine()'

nnoremap ,gtdt <ESC>:call AgendaGoToDateWithInput()<CR>

call AgendaGoToToday()

call TQ84_log_dedent()
