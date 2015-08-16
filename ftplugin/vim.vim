:map <buffer> ! :so %<CR>

fu! <SID>TabberInsertFunction() " {

  call TQ84_log_indent(expand('<sfile>'))

  let l:jumpTo_1 = Tabber#MakeJumpToMark()
  let l:jumpTo_2 = Tabber#MakeJumpToMark()
  let l:jumpTo_3 = Tabber#MakeJumpToMark()

   call Tabber#InsertUnindentedSkeleton(
   \ ['fu! ' . l:jumpTo_1 . '(' . l:jumpTo_2 . ') " {',
   \  "  call TQ84_log_indent(expand('<sfile>'))",
   \  '  ' . l:jumpTo_3,
   \  "  call TQ84_log_dedent()",
   \  'endfu " }' ,
   \ ])


   call Tabber#Add([
      \ ['jump-to', l:jumpTo_1 ],
      \ ['jump-to', l:jumpTo_2 ],
      \ ['jump-to', l:jumpTo_3 ]
      \ ])

   normal i

   call Tabber#TabPressed()

   silent! zo

  call TQ84_log_dedent()
endfu " }

nnoremap ,fu :call <SID>TabberInsertFunction()<CR>
