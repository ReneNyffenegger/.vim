call TQ84_log_indent(expand('<sfile>'))

fu! <SID>ConvertDotFile(dotfile_with_path, format, show) " {

  call TQ84_log_indent(expand('<sfile>'))
  call TQ84_log('a:dotfile_with_path = ' . a:dotfile_with_path)
  call TQ84_log('a:format = ' . a:format)

  let l:dir     = fnamemodify(a:dotfile_with_path, ':h')
  let l:dotfile = fnamemodify(a:dotfile_with_path, ':t')
  let l:dotfile_without_suffix = fnamemodify(l:dotfile, ':r')
  let l:outfile = l:dotfile_without_suffix . '.' . a:format

  call TQ84_log('l:dir = ' . l:dir)
  call TQ84_log('l:dotfile = ' . l:dotfile)
  call TQ84_log('l:dotfile_without_suffix = ' . l:dotfile_without_suffix)

  let l:dot_exe = 'c:\tools\graphviz-2.38\release\bin\dot.exe'

  let l:dot_response = tq84#SystemInDir(l:dir, l:dot_exe . ' -Gcharset=utf8 -T' . a:format . ' -o' . l:outfile . ' ' . l:dotfile)

  if l:dot_response =~# 'Error:'

     call TQ84_log('returning, because of error message: ' . l:dot_response)
     echo l:dot_response
     call TQ84_log_dedent()
     return


  endif

  if a:show
     call TQ84_log('a:show is true')

   "
   " The following line contains an «echo 1» in order to circumvent
   " an E371 error, see also
   "   http://vi.stackexchange.com/questions/4746/how-do-i-combine-system-and-start-in-a-windows-environment
   " call tq84#SystemInDir(l:dir, 'echo 1 & start ' . l:outfile)
   " Solution given in SE is to use «start /b»
     call tq84#SystemInDir(l:dir, 'start /b ' . l:outfile)
  endif

  call TQ84_log_dedent()

endfu " }


nnoremap <buffer> ! :call <SID>ConvertDotFile(expand('%:p'), 'pdf', 1)<CR>

call TQ84_log_dedent()
