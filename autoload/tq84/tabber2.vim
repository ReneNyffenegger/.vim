call TQ84_log_indent(expand('<sfile>'))

fu tq84#tabber2#init(tabFunc) " {
   call TQ84_log_indent(expand('<sfile>'))

   if exists('b:tabber2')
      call TQ84_log('b:tabber2 already exists, returning')
      call TQ84_log_dedent()
      return
   endif

   let b:tabber2 = {}

   "  Unfortunately, all syntax that is set up as part of the
   " »filetype detect mechanism« is later cleaned up when (before)
   "  syntax files are runtime'd (which takes place after the
   "  filetype detect mechanism.
   "  "
   "  I could place something in after/syntax/..., but
   "  I don't want to spread the initialisation across to
   "  files. Therefore, set syntax_todo to one to remember
   "  to setup syntax later:
   let b:tabber2.syntax_todo = 1

   let b:tabber2.currJumpToMark = 9999
   let b:tabber2.tabFunc        = a:tabFunc

   inoremap <buffer> <TAB>         =tq84#tabber2#tabPressed()<CR>
 " inoremap <buffer> <TAB> <ESC>:call tq84#tabber2#tabPressed()<CR>


   call TQ84_log_dedent()
endfu " }

fu tq84#tabber2#nextJumpToMark() " {
   call TQ84_log_indent(expand('<sfile>'))

   if b:tabber2.syntax_todo
      call tq84#tabber2#setupSyntax()
   endif

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

   let l:virtcolBeforeEating=virtcol('.')
   call TQ84_log(printf('going to eat character. mode()=%s, virtcol(".")=%d, virtcol("$")=%d', mode(), l:virtcolBeforeEating, virtcol('$')))
   normal x
   call TQ84_log(printf('going to eat character. mode()=%s, virtcol(".")=%d, virtcol("$")=%d', mode(), virtcol('.'), virtcol('$')))

   if l:virtcolBeforeEating == virtcol('.') + 1
      startinsert!
   else
      startinsert
   endif

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

   call TQ84_log('call b:tabber2.tabFunc()')
   let l:ret = b:tabber2.tabFunc()

   call TQ84_log_dedent()

   return l:ret
 endfu " }

fu tq84#tabber2#setupSyntax() " {
   call TQ84_log_indent(expand('<sfile>'))

   let l:cmd = 'syntax match JumpMark /[' . nr2char(b:tabber2.currJumpToMark) . '-' . nr2char(b:tabber2.currJumpToMark+1000) . ']/ conceal'
   call TQ84_log('cmd = ' . l:cmd)
   exe l:cmd

   let l:cmd = 'hi JumpMark guibg=grey guifg=yellow'
   call TQ84_log('cmd = ' . l:cmd)
   exe l:cmd

   set conceallevel=3

   let b:tabber2.syntax_todo = 0
   call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
