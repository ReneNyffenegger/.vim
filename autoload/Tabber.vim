call TQ84_log_indent(expand('<sfile>'))

let s:currJumpToMark =  9999

let s:instruction_stack = []

fu! Tabber#TabPressed() " {
  call TQ84_log_indent(expand('<sfile>'))

  call TQ84_log('len(s:instruction_stack) = ' . len(s:instruction_stack))

  if len(s:instruction_stack) == 0
     iunmap <TAB>
     call GUI#InsertModeInsertText(nr2char(9))
     inoremap  <TAB> <ESC>:call Tabber#TabPressed()<CR>
  else

     let l:curr_instructions = s:instruction_stack[-1]
     call TQ84_log('len(l:curr_instructions) = ' . len(l:curr_instructions))

     if len(l:curr_instructions) == 0 " {
        throw "len of l:curr_instructions should never be 0!"
     endif " }

     let l:curr_instruction      = l:curr_instructions[0]
     let l:curr_instruction_type = l:curr_instruction[ 0]

     call TQ84_log('curr_instruction_type: ' . l:curr_instruction_type)

     if     l:curr_instruction_type == 'ins-const' " {

        call TQ84_log('An insert instruction, text = ' . l:curr_instruction[1] )
        call GUI#InsertModeInsertText(l:curr_instruction[1])

        call remove(l:curr_instructions, 0)
        if len(l:curr_instructions) == 0 " {
           call remove(s:instruction_stack, -1)
        endif " }

     " }
     elseif l:curr_instruction_type == 'jump-to' " {

        let l:jump_to = l:curr_instruction[1]
        call TQ84_log('Jumping to ' . char2nr(l:jump_to))
        let l:found_line_nr = search(l:jump_to, 'w')

        if l:found_line_nr != getpos('.')[1]
           throw 'l:found_line_nr: ' . l:found_line_nr . ', but getpos returns ' . getpos('.')[1]
        endif

"       let l:cursor_pos    = getpos('.')[2]
"       call TQ84_log('found_line_nr: ' . l:found_line_nr . ', cursor now at ' . getpos('.')[1] . '/' . getpos('.')[2])

"       let l:lineText = getline(l:found_line_nr)
"       call setline(l:found_line_nr, l:lineText[0 : l:cursor_pos-1] . l:lineText[l:cursor_pos :])

        normal x

        startinsert

        call remove(l:curr_instructions, 0)
        if len(l:curr_instructions) == 0 " {
           call remove(s:instruction_stack, -1)
        endif " }

     " }
     else " {

       throw "unknown instruction type " . l:curr_instruction_type

     endif " }

  endif

  call TQ84_log_dedent()

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

  let l:save_foldenable = &foldenable
  let &foldenable = 0

  let l:currLineNo   = line('.')
  let l:currLineText = getline(l:currLineNo)

  call TQ84_log('curr Line: ' . l:currLineText . ' (' . l:currLineNo . ')')

  if l:currLineText !~# '^\s*$'
     call TQ84_log('insert extra line')
     normal 0o
  endif

  let l:firstLine = line('.')
  call TQ84_log('l:firstLine = ' . l:firstLine)

  execute "normal " . (len(a:lines)-1) . 'o' . nr2char(27)

  for l in range(0, len(a:lines)-1)
    call TQ84_log('setting line ' . (l:firstLine+l) . ' to ' . a:lines[l])
    call setline(l:firstLine+l, a:lines[l])
  endfor

  let &foldenable = l:save_foldenable

  call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
