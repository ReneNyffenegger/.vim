call TQ84_log_indent(expand('<sfile>'))

let s:instruction_stack = []

fu! Tabber#TabPressed() " {
  call TQ84_log_indent(expand('<sfile>'))

  call TQ84_log('len(s:instruction_stack) = ' . len(s:instruction_stack))

  if len(s:instruction_stack) == 0
     let l:ret = nr2char(9)
  else

     let l:curr_instructions = s:instruction_stack[-1]
     call TQ84_log('len(l:curr_instructions) = ' . len(l:curr_instructions))

     if len(l:curr_instructions) == 0 " {
        throw "len of l:curr_instructions should never be 0!"
     endif " }

     let l:curr_instruction      = l:curr_instructions[0]
     let l:curr_instruction_type = l:curr_instruction[ 0]

     if l:curr_instruction_type == 'ins-const' " {

        let l:ret = l:curr_instruction[1]

        call TQ84_log('An insert instruction, text = ' . l:ret )

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

  return l:ret
endfu " }

fu! Tabber#Add(instructions) " {
  call TQ84_log_indent(expand('<sfile>'))

  call add(s:instruction_stack, a:instructions)

  call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
