call TQ84_log_indent(expand('<sfile>'))

fu! tq84#tabber2#init() " {
   call TQ84_log_indent(expand('<sfile>'))

   if exists('b:tabber2') " {
      call TQ84_log('b:tabber2 already exists, returning')
      call TQ84_log_dedent()
      return
   endif " }

   let b:tabber2 ={}

 " Unfortunately, all syntax that is set up as part of the
 "»filetype detect mechanism« is later cleaned up when (before)
 " syntax files are runtime'd (which takes place after the
 " filetype detect mechanism.
 " "
 " I could place something in after/syntax/..., but
 " I don't want to spread the initialisation across to
 " files. Therefore, set syntax_todo to one to remember
 " to setup syntax later:
   let b:tabber2.syntax_todo = 1

   let b:tabber2.currJumpToMark = 9999
"  let b:tabber2.tabFunc        = a:tabFunc

   inoremap <buffer> <TAB>         =tq84#tabber2#tabPressed()<CR>
 " inoremap <buffer> <TAB> <ESC>:call tq84#tabber2#tabPressed()<CR>

 " The list of funcrefs to be checked after a Tab was pressed:
   let b:tabber2.expansionRuleFuncs = []

   let b:instructions = []

   call TQ84_log_dedent()
endfu " }

fu! tq84#tabber2#addExpansionRuleFunc(expansionRuleFunc) " {
   call TQ84_log_indent('tq84#tabber2#addExpansionRule')

   call add(b:tabber2.expansionRuleFuncs, a:expansionRuleFunc)
    
   call TQ84_log_dedent()
endfu " }

fu! tq84#tabber2#expansionRuleWord(word, lines) " {

"  call TQ84_log_indent(printf('tq84#tabber2#expansionRuleWord, testing if word=%s, wordReplace=%s', a:word, a:wordReplace))
   call TQ84_log_indent(printf('tq84#tabber2#expansionRuleWord, testing if word=%s'                , a:word))

 " TODO: A buffer variable could be used here...
   let l:wordLeftOfCursor = tq84#buf#wordLeftOfCursor()
   call TQ84_log('wordLeftOfCursor=' . l:wordLeftOfCursor . '<')

   if     l:wordLeftOfCursor == a:word " {

          call TQ84_log(printf('found %s', a:word))

          let l:lines=copy(a:lines)
          let l:instructions = []

          let l:jumpNo = 1

          call TQ84_log_indent('Replacing jump markers')
          while 1 " {
       
            let l:jumpPattern = '!' . l:jumpNo . '!'

            call TQ84_log(printf('Trying l:jumpPattern %s', l:jumpPattern))
       
            let l:matchedLine = match(a:lines, l:jumpPattern)
       
            if  l:matchedLine > -1 " {

                call TQ84_log('jumpPattern found')
                let l:jumpMark = tq84#tabber2#nextJumpToMark()

                if l:jumpNo == 1
                   let l:firstJumpMark = l:jumpMark
                else
                   call add(l:instructions, function('tq84#tabber2#jumpToMarkAndEatIt', [l:jumpMark]))
                endif
        
                let l:lines[l:matchedLine] = substitute(l:lines[l:matchedLine], l:jumpPattern, l:jumpMark, '')

                let l:jumpNo = l:jumpNo + 1
       
                continue
            endif " }
       
           
            call TQ84_log(printf('No match found for l:jumpNo=%d, exiting loop', l:jumpNo))
            break
       
          endwhile " }
          call TQ84_log_dedent()

          call TQ84_log_indent('Replace triggering word')
          call tq84#buf#logLineAndPos()
          let l:line = getline('.')
          let l:col  = col    ('.')
"         let l:line = strpart(l:line, 0, l:col - len(a:word) -1 ) . a:wordReplace . strpart(l:line, l:col)
          let l:line = strpart(l:line, 0, l:col - len(a:word) -1 ) . strpart(l:line, l:col)
          let l:col = l:col - len(a:word) -1 
          call setline('.', l:line)
          call TQ84_log('l:line=' . l:line)
          call TQ84_log('l:col='  . l:col)
"         call setpos('.', [0, line('.'), l:col - len(a:word)+len(a:wordReplace), 0])
"         call setpos('.', [0, line('.'), l:col - len(a:word)                   , 0])
          call TQ84_log_dedent()

          call TQ84_log(printf('adding %d instructions to b:instructions', len(l:instructions)))
          call extend(b:instructions, reverse(l:instructions))
          call TQ84_log(printf('len(b:instructions)=%d', len(b:instructions)))

          call tq84#buf#insertRightOfCursor(l:lines[0])

"         call tq84#buf#insertLines(l:lines[1:], col('.')-1 - len(a:word))
          call tq84#buf#insertLines(l:lines[1:], l:col)

          call TQ84_log('jump to first jump mark')
          call tq84#tabber2#jumpToMarkAndEatIt(l:firstJumpMark)

          call TQ84_log_dedent()
          return 1

   endif " }

   call TQ84_log('expansionRuleWord: word ' . a:word . ' was not found, returning 0')
   call TQ84_log_dedent()
   return 0

endfu " }

fu! tq84#tabber2#nextJumpToMark() " {
   call TQ84_log_indent('tq84#tabber2#nextJumpToMark')

   if b:tabber2.syntax_todo
      call TQ84_log('b:tabber2.syntax_todo -> tq84#tabber2#setupSyntax()')
      call tq84#tabber2#setupSyntax()
   endif

   let b:tabber2.currJumpToMark = b:tabber2.currJumpToMark + 1
   call TQ84_log('returning currJumpToMark = ' . b:tabber2.currJumpToMark)

   call TQ84_log_dedent()
   return nr2char(b:tabber2['currJumpToMark'])
endfu " }

fu! tq84#tabber2#jumpToMarkAndEatIt(jumpMark) " {
   call TQ84_log_indent('tq84#tabber2#jumpToMarkAndEatIt, jumpMark=' . char2nr(a:jumpMark))

   if search(a:jumpMark) == 0 " {
      call TQ84_log('warning, jumpMark ' . char2nr(a:jumpMark) . ' not found')
      call TQ84_log_dedent()
      return ''
   endif  " }

   let l:virtcolBeforeEating=virtcol('.')
"  call TQ84_log(printf('going to eat character. mode()=%s, virtcol(".")=%d, virtcol("$")=%d', mode(), l:virtcolBeforeEating, virtcol('$')))
   normal x
"  call TQ84_log(printf('going to eat character. mode()=%s, virtcol(".")=%d, virtcol("$")=%d', mode(), virtcol('.'), virtcol('$')))

   if l:virtcolBeforeEating == virtcol('.') + 1
      startinsert!
   else
      startinsert
   endif

   call TQ84_log_dedent()
   return ''

endfu " }

fu! tq84#tabber2#tab() " {
   call TQ84_log_indent(expand('<sfile>'))

   call TQ84_log('return nr2char(9)')

   call TQ84_log_dedent()
   return nr2char(9)
endfu " }

fu! tq84#tabber2#tabPressed() " {
   call TQ84_log_indent('tq84#tabber2#tabPressed')

   for l:Func in b:tabber2.expansionRuleFuncs " {

       call TQ84_log('trying next l:Func')
       if l:Func()

          call TQ84_log('l:Func returned true')

          call TQ84_log_dedent()
          return ''

       endif

   endfor " }

   call TQ84_log(printf('tabPressed, no expansionRuleFunc returned true, len(b:instructions)=%d', len(b:instructions)))

   if len(b:instructions) " {

      call TQ84_log('Removing last element from b:instructions')
      let l:InstructionFunc = remove(b:instructions, -1)
      call TQ84_log('calling ' . string(l:InstructionFunc))
      let l:ret = l:InstructionFunc()
      call TQ84_log('l:ret = ' . l:ret . '<')
      call TQ84_log_dedent()
      return l:ret

   endif " }

   call TQ84_log('No word found, instructions empty, returning tab')

   call TQ84_log_dedent()

   return nr2char(9)

 endfu " }

fu! tq84#tabber2#setupSyntax() " {
   call TQ84_log_indent('tq84#tabber2#setupSyntax')

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
