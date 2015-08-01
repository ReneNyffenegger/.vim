call TQ84_log_indent(expand("<sfile>"))

fu! Font#Resize(by)
  call TQ84_log_indent(expand("<sfile>") . "-Larger (by = " . a:by . ')')
  
  let l:font = &guifont

  call TQ84_log('font old: ' . l:font)

  let l:font_parts = matchlist(l:font, '\(\w\+\):\(\w\+\):\(\w\+\)')

  let l:font_size_parts = matchlist(l:font_parts[2], '\(\w\)\(\d\+\)')

  let l:font_new = l:font_parts[1] . ':' . l:font_size_parts[1] . (l:font_size_parts[2] + a:by) . ':' . l:font_parts[3]

  call TQ84_log('font new: ' . l:font_new)

  let &guifont = l:font_new

  call TQ84_log_dedent()

endfu

call TQ84_log_dedent()
