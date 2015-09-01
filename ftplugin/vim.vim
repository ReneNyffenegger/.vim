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

 " normal i

   call Tabber#TabPressed()

   silent! zo

   call TQ84_log_dedent()

   return ''
endfu " }
fu! <SID>TabberInsertFor() " {

  call TQ84_log_indent(expand('<sfile>'))

  let l:jumpTo_1 = Tabber#MakeJumpToMark()
  let l:jumpTo_2 = Tabber#MakeJumpToMark()
  let l:jumpTo_3 = Tabber#MakeJumpToMark()

   call Tabber#InsertIndentedSkeleton(
   \ ['for ' . l:jumpTo_1 . ' in ' . l:jumpTo_2,
   \  '  ' . l:jumpTo_3,
   \  'endfor' ,
   \ ])


   call Tabber#Add([
      \ ['jump-to', l:jumpTo_1 ],
      \ ['jump-to', l:jumpTo_2 ],
      \ ['jump-to', l:jumpTo_3 ]
      \ ])

   normal i

   call Tabber#TabPressed()

"  silent! zo

   return ""
  call TQ84_log_dedent()
endfu " }

fu! <SID>TabberLog() " {

  call TQ84_log_indent(expand('<sfile>'))

  call Tabber#Add([
     \ ['ins-const', 'call TQ84_log('],
     \ ['ins-const', ')' . nr2char(13)],
     \ ])

" normal i
  call Tabber#TabPressed()

  call TQ84_log_dedent()

  return ''

endfu " }

nnoremap <buffer> ,fu i=<SID>TabberInsertFunction()<CR>
inoremap <buffer> ,fu  =<SID>TabberInsertFunction()<CR>
inoremap <buffer> ,for =<SID>TabberInsertFor()<CR>
inoremap <buffer> ,log =<SID>TabberLog()<CR>
