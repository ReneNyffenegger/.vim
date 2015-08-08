call TQ84_log_indent(expand('<sfile>'))

fu! tq84#SystemInDir(dir, cmd) " {

  call TQ84_log_indent(expand("<sfile>"))

  call TQ84_log('a:dir = ' . a:dir)
  call TQ84_log('a:cmd = ' . a:cmd)


  let l:cwd = getcwd()
  call TQ84_log('l:cwd = ' . l:cwd)

  execute "cd " . a:dir

  let l:response = system (a:cmd)

  execute "cd " .  l:cwd

  call TQ84_log_dedent()

  return l:response

endfu " }

fu! tq84#EmbedVisualSelection(txt_before, txt_after) range " {
  call TQ84_log_indent(expand('<sfile>'))

" Determining beginning ...
  let l:line_b    = line("'<")
  let l:line_e    = line("'>")

" ... and end of visual selection
  let l:col_b     = col ("'<")
  let l:col_e     = col ("'>")

  call TQ84_log('Lines: ' . l:line_b . "-" . l:line_e . ", columns " . l:col_b . ":" . l:col_e)

" Append after end of visual selection
  call setpos(".", [0, l:line_e, l:col_e, 0])
  execute "normal a" . a:txt_after . nr2char(27)

" Insert befor beginning of visual selection
  call setpos(".", [0, l:line_b, l:col_b, 0])
  execute "normal i" . a:txt_before . nr2char(27)

  call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
