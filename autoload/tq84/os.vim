call TQ84_log_indent(expand('<sfile>'))

fu! tq84#os#filesDiffer(file1, file2) " {
    call TQ84_log_indent(printf('tq84#os#filesDiffer, %s - %s', a:file1, a:file2))

    let l:file1 = tq84#os#correctPathSlashes(a:file1)
    let l:file2 = tq84#os#correctPathSlashes(a:file2)

    if tq84#os#isWindows()
       let l:cmd = printf('fc %s %s'  , l:file1, l:file2)
    else
       let l:cmd = printf('diff %s %s', l:file1, l:file2)
    endif

    call TQ84_log('l:cmd = ' . l:cmd)

    let l:cmdOut = system(l:cmd)
    call TQ84_log('l:cmdOut = ' . l:cmdOut)
    
    call TQ84_log('v:shell_error: ' . v:shell_error)
    call TQ84_log_dedent()

    return v:shell_error != 0
endfu " }

fu! tq84#os#isWindows() " {
    if !has('unix')
       call TQ84_log('tq84#os#isWindows: yes')
       return v:true
    endif

    call TQ84_log('tq84#os#isWindows: no')
    return v:false
endfu " }

fu! tq84#os#correctPathSlashes(path) " {
    call TQ84_log_indent('tq84#os#correctPathSlashes: ' . a:path)

    if tq84#os#isWindows()
       let l:path = substitute(a:path, '/', '\', 'g')
    else
       let l:path = substitute(a:path, '\', '/', 'g')
    endif

    call TQ84_log('tq84#os#correctPathSlashes returning ' . l:path)

    call TQ84_log_dedent()
    return l:path
endfu " }

fu! tq84#os#pathSeperator() " {
  if tq84#os#isWindows()
     return '\'
  endif

  return '/'
endfu " }

call TQ84_log_dedent()
