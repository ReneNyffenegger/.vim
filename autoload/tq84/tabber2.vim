call TQ84_log_indent(expand('<sfile>'))

fu tq84#tabber2#init(tabFunc) " {
   call TQ84_log_indent(expand('<sfile>'))

   if exists('b:tabber2')
      call TQ84_log('b:tabber2 already exists, returning')
      call TQ84_log_dedent()
      return
   endif

   let b:tabber2 = {}

   let b:tabber2.currJumpToMark = 9999
   let b:tabber2.tabFunc        = a:tabFunc
      
   inoremap <buffer> <TAB> =tq84#tabber2#tabPressed()<CR>
 
   call TQ84_log_dedent()
endfu " }

fu tq84#tabber2#nextJumpToMark() " {
   call TQ84_log_indent(expand('<sfile>'))

   let b:tabber2['currJumpToMark']   = b:tabber2['currJumpToMark'] + 1
   call TQ84_log('currJumpToMark = ' . b:tabber2['currJumpToMark'])

   call TQ84_log_dedent()
   return nr2char(b:tabber2['currJumpToMark'])
endfu " }

fu tq84#tabber2#jumpToMarkAndEatIt(jumpMark) " {
   call TQ84_log_indent(expand('<sfile>') . ', jumpMark=' . char2nr(a:jumpMark))

   if search(a:jumpMark) == 0 " {
      call TQ84_log('warning, jumpMark ' . char2nr(a:jumpMark) . ' not found')
      call TQ84_log_dedent()
      return ''
   endif  " }

   normal x

   call TQ84_log_dedent()
   return ''

endfu " }

fu tq84#tabber2#tab() " {
   call TQ84_log_indent(expand('<sfile>'))

   call TQ84_log('return nr2char(9)')

   call TQ84_log_dedent()
   return nr2char(9)
endfu " }

fu tq84#tabber2#tabPressed() " {
   call TQ84_log_indent(expand('<sfile>'))

   let l:ret = b:tabber2.tabFunc()

   call TQ84_log_dedent()

   return l:ret
 endfu " }

call TQ84_log_dedent()
