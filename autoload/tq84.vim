call TQ84_log_indent(expand('<sfile>'))

fu! tq84#SystemInDir(dir, cmd) " {

  call TQ84_log_indent(expand("<sfile>"))

  try

    call TQ84_log('a:dir = ' . a:dir)
    call TQ84_log('a:cmd = ' . a:cmd)
  
  
    let l:cwd = getcwd()
    call TQ84_log('l:cwd = ' . l:cwd)
  
    execute "cd " . a:dir
  
    let l:response = system (a:cmd)

  execute "cd " .  l:cwd

  catch /.*/
    call TQ84_log('exception caught: ' . v:exception)
    let l:response = v:exception
  endtry

  call TQ84_log_dedent()

  return l:response

endfu " }

fu! tq84#EmbedVisualSelection(txt_before, txt_after) range " {
  call TQ84_log_indent(expand('<sfile>'))

" Determining beginning and end of visual selection
  let l:line_b    = line("'<")
  let l:line_e    = line("'>")
  let l:col_b     = col ("'<")
  let l:col_e     = col ("'>")

" also get position of cursor
  let l:line_c    = line(".")
  let l:col_c     = col (".")

  call TQ84_log('Selection:  ' . l:line_b . ":" . l:col_b . ' - ' . l:line_e . ':' . l:col_e)
  call TQ84_log('Cursor: ' . l:line_c . ':' . l:col_c)

  let l:line = getline(l:line_e)
  let l:line = strpart(l:line, 0, l:col_e) . a:txt_after . strpart(l:line, l:col_e)

  call TQ84_log('l:line: ' . l:line)

  call setline(l:line_e, l:line)

  let l:line = getline(l:line_b)
  let l:line = strpart(l:line, 0, l:col_b-1) . a:txt_before . strpart(l:line, l:col_b-1)

  call TQ84_log('l:line: ' . l:line)

  call setline(l:line_b, l:line)

  call setpos('.', [0, l:line_b, l:col_b + len(a:txt_before) , 0])

  call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
