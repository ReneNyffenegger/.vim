call TQ84_log_indent(expand('<sfile>'))

set foldmarker={,}
set foldmethod=marker
set foldtext=getline(v:foldstart)

fu! <SID>StatusLine()
" call TQ84_log_indent(expand('<sfile>'))

  let l:pos_cursor=getpos('.')
  
  let l:lineDay  =search('\v^ *\d\d (Mo|Di|Mi|Do|Fr|Sa|So)>', 'b')
  let l:lineMonth=search('\v^ *\d\d \{'                     , 'b')
  let l:lineYear =search('\v^ *\d\d\d\d \{'                 , 'b')

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

endfu

fu! s:SID()
  call TQ84_log_indent(expand('<sfile>'))
  let s:SID=matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
  call TQ84_log('s:SID=' . s:SID)
  call TQ84_log_dedent()
  return s:SID
endfu

execute "setl statusline=%!<SNR>" . s:SID() . '_StatusLine()'

call TQ84_log_dedent()
