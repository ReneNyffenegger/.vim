call TQ84_log_indent(expand('<sfile>'))

let s:currJumpToMark =  9999

let s:instruction_stack = []

fu! Tabber#TabPressed() " {
  call TQ84_log_indent(expand('<sfile>'))

  call TQ84_log('len(s:instruction_stack) = ' . len(s:instruction_stack))
  call TQ84_log('virtcol(.) = ' . virtcol('.') . ' / virtcol($): ' . virtcol('$'))

  if len(s:instruction_stack) == 0 " {
     call TQ84_log('insert verbatim TAB since instruction_stack is empty')
     iunmap <TAB>
     call GUI#InsertModeInsertText(nr2char(9))
     inoremap  <TAB> =Tabber#TabPressed()<CR>
      " }
  else " {

     let l:curr_instructions = s:instruction_stack[-1]
     call TQ84_log('len(l:curr_instructions) = ' . len(l:curr_instructions))

     if len(l:curr_instructions) == 0 " {
        echo "len of l:curr_instructions should never be 0!"
        call TQ84_log("len of l:curr_instructions should never be 0, returning")
        call TQ84_log_dedent()
        return ''
     endif " }

     let l:curr_instruction      = l:curr_instructions[0]
     let l:curr_instruction_type = l:curr_instruction[ 0]

     call TQ84_log('curr_instruction_type: ' . l:curr_instruction_type)

     if     l:curr_instruction_type == 'ins-const' " {

        let l:constantText = l:curr_instruction[1]

        call TQ84_log('An insert instruction, text: >' . l:constantText . '<')

        call remove(l:curr_instructions, 0)
        if len(l:curr_instructions) == 0 " {
           call remove(s:instruction_stack, -1)
        endif " }

        call GUI#InsertModeInsertText(l:curr_instruction[1])

     " }
     elseif l:curr_instruction_type == 'jump-to' " {

        let l:jump_to = l:curr_instruction[1]
        call TQ84_log('Jumping to ' . char2nr(l:jump_to))
        let l:found_line_nr = search(l:jump_to, 'w')

        if l:found_line_nr != getpos('.')[1]
           throw 'jump-to: l:found_line_nr: ' . l:found_line_nr . ', but getpos returns ' . getpos('.')[1]
        endif

        call TQ84_log("I have jumped")

        call GUI#LogLineAndPos()

        if virtcol('.') + 1 == virtcol('$')
           call TQ84_log('After jump: ' . virtcol('.') . ' fell on last character [' . virtcol('$') . '], so startinsert!')
           normal x
           startinsert!
        else
           call TQ84_log('After jump: ' . virtcol('.') . ' did not fall on last character [' . virtcol('$') . '], so startinsert')
           normal x
           startinsert
        endif

        call remove(l:curr_instructions, 0)
        if len(l:curr_instructions) == 0 " {
           call remove(s:instruction_stack, -1)
        endif " }

     " }
     else " {

       throw "unknown instruction type " . l:curr_instruction_type

     endif " }

  endif " }

  call TQ84_log_dedent()

  return ''

endfu " }

fu! Tabber#Add(instructions) " {
  call TQ84_log_indent(expand('<sfile>'))

  call add(s:instruction_stack, a:instructions)

  call TQ84_log_dedent()
endfu " }

fu! Tabber#MakeJumpToMark() " {
  call TQ84_log_indent(expand('<sfile>'))

  let s:currJumpToMark = s:currJumpToMark + 1
  call TQ84_log('currJumpToMark: ' . s:currJumpToMark)

  call TQ84_log_dedent()

  return nr2char(s:currJumpToMark)
endfu " }

fu! Tabber#InsertUnindentedSkeleton(lines) " {
  call TQ84_log_indent(expand('<sfile>') . ' len(lines): ' . len(a:lines))

  let l:lines = []

" let l:save_foldenable = &foldenable
" let &foldenable = 0

  let l:jumpPositions = {}

  call TQ84_log_indent('looping over lines')
  for l:line in a:lines
    let l:matched = matchlist(l:line, '\v!(\d+)!')

    call TQ84_log('l:line = ' . l:line)

    while len(l:matched)

      call TQ84_log('len(l:matched) = ' . len(l:matched) . ', l:matched[1] = ' . l:matched[1] . ', l:line = ' . l:line)

      let l:jumpMark = Tabber#MakeJumpToMark()
      let l:jumpPositions[l:matched[1]] = l:jumpMark
      let l:line = substitute(l:line, '\v!\d+!', l:jumpMark, '')
      call TQ84_log('after substitute: l:line = ' . l:line)

      let l:matched = matchlist(l:line, '\v!(\d+)!')

    endwhile

    let l:lines += [l:line]
  endfor
  call TQ84_log_dedent()

  call GUI#InsertLines(l:lines)

  let l:instructions = []
  for l:j in sort(map(keys(l:jumpPositions), 'v:val + 0'))
    let l:instructions += [ ['jump-to', l:jumpPositions[l:j] ] ]
  endfor

  if len(l:instructions)
     call Tabber#Add(l:instructions)
  endif

" let &foldenable = l:save_foldenable

  call TQ84_log_dedent()

endfu " }

fu! Tabber#InsertIndentedSkeleton(lines) " {
  call TQ84_log_indent(expand('<sfile>') . ' len(lines): ' . len(a:lines))

" let l:save_foldenable = &foldenable
" let &foldenable = 0

  let l:currLineNo   = line('.')
  let l:currCol      = virtcol('.')
  let l:currLineText = getline(l:currLineNo)

" call TQ84_log('curr Line: ' . l:currLineText . ' (' . l:currLineNo . ')')
  call GUI#LogLineAndPos()

  let l:lines = map(a:lines, '"' . repeat(' ', l:currCol-1) . '" . v:val')

  call Tabber#InsertUnindentedSkeleton(l:lines)

" let &foldenable = l:save_foldenable

  call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
