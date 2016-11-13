call TQ84_log_indent(expand('<sfile>'))

fu! tq84#SystemInDir(dir, cmd) " {

  call TQ84_log_indent(expand("<sfile>"))

  let l:dir = a:dir
  if ! has('unix')
    let l:dir = substitute(l:dir, '/', '\', 'g')
  endif

  try

    call TQ84_log('l:dir = ' . l:dir)
    call TQ84_log('a:cmd = ' . a:cmd)
  
    let l:cwd = getcwd()
    call TQ84_log('l:cwd = ' . l:cwd)
  
    execute "cd " . l:dir
  
    let l:response = system (a:cmd)
    call TQ84_log('l:response = ' . l:response)

  execute "cd " .  l:cwd

  catch /.*/
    call TQ84_log('exception caught: ' . v:exception)
    let l:response = v:exception
  endtry

  call TQ84_log_dedent()

  return l:response

endfu " }

fu! tq84#OpenDocument(doc) " {
  call TQ84_log_indent(expand("<sfile>") . ' ' . a:doc)

  if has('unix')
    let l:doc = substitute(a:doc, '\', '/', 'g')

    let l:cmd = 'xdg-open ' . l:doc

  else
    let l:doc = substitute(a:doc, '/', '\', 'g')

    let l:cmd = l:doc
  endif

  call TQ84_log('l:cmd = ' . l:cmd)

  let l:cmd_out = system(l:cmd)
  if v:shell_error != 0
     echo l:cmd_out
  endif

  call TQ84_log_dedent()
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

fu! tq84#CopyFile(src_file, dest_file) " {

  call TQ84_log_indent(expand('<sfile>') . ' src_file=' . a:src_file . ', dest_file=' . a:dest_file)

  let l:file     = fnamemodify(a:src_file , ':t')
  let l:dest_dir = fnamemodify(a:dest_file, ':h')

  call TQ84_log('file=' . l:file . ', dest_dir=' . l:dest_dir)

  if ! isdirectory(l:dest_dir)

    call TQ84_log('dest_dir does not exist, creating it')
    call mkdir(l:dest_dir, 'p')

  endif

  let l:cmd = 'copy ' . a:src_file . ' ' . a:dest_file
  call TQ84_log('cmd = ' . l:cmd)

  let l:dummy = system(l:cmd)

  call TQ84_log_dedent()

endfu " }

fu! tq84#CopyToUniformServer(src_file, dest_dir) " {

  call TQ84_log_indent(expand('<sfile>') . ' src_file=' . a:src_file . ', dest_dir=' . a:dest_dir)

  let l:fileName = fnamemodify(a:src_file, ':t')
  call tq84#CopyFile(a:src_file, $UNI_SERVER_Z_ROOT . '\www\' . a:dest_dir . '\' . l:fileName)

  call TQ84_log_dedent()

endfu " }

fu! tq84#SwitchBodyAndSpec() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:extension         =  expand("%:e"  )
  let l:without_extension =  expand("%:p:r")

  call TQ84_log('extension: '   . l:extension)
  call TQ84_log('without ext: ' . l:without_extension)

  if l:extension ==? 'pks' " {
     execute 'e ' . l:without_extension . '.pkb'
     call TQ84_log_dedent()
     return
  endif " }

  if l:extension ==? 'pkb' " {
     execute 'e ' . l:without_extension . '.pks'
     call TQ84_log_dedent()
     return
  endif " }

  let l:file_name = expand("%:t")
  let l:directory = expand("%:h")
  if l:file_name ==? 'spec.plsql' " {
     execute 'e ' . l:directory . '/' . 'body.plsql'
     call TQ84_log_dedent()
     return
  endif " }
  if l:file_name ==? 'body.plsql' " {
     execute 'e ' . l:directory . '/' . 'spec.plsql'
     call TQ84_log_dedent()
     return
  endif " }

  call TQ84_log_dedent()
endfu " }

fu! tq84#toggle_highlight_word_under_cursor() " {

  call TQ84_log_indent(expand("<sfile>"))

  if ! exists('s:highlight_word_under_cursor') || s:highlight_word_under_cursor == 0 " {
     call TQ84_log('s:highlight_word_under_cursor does not exist')

     let @/=expand('<cword>')

     let s:highlight_word_under_cursor = matchadd('Search', @/)

  else

     call matchdelete(s:highlight_word_under_cursor) 
     let s:highlight_word_under_cursor=0

  endif " }


  call TQ84_log_dedent()

endfu " }



call TQ84_log_dedent()
