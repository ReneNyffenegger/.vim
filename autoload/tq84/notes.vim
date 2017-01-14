call TQ84_log_indent(expand('<sfile>'))

fu! tq84#notes#buffers() " {
   call TQ84_log_indent('tq84#notes#buffers')

   let l:ret = []

   for l:bufName in filter(tq84#buf#buffers(), 'len(v:val)') " {
       
       let l:bufNameFull = fnamemodify(l:bufName, ':p')

       if l:bufNameFull =~ 'notes/notes'
          let l:bufNameReduced = substitute(l:bufNameFull, '.*notes/notes/', '', '')
          call TQ84_log('Adding ' . l:bufNameReduced . ' (full=' . l:bufNameFull . ', buf=' . l:bufName . ')')
          call add(l:ret, l:bufNameReduced)
       else
          call TQ84_log('Not adding ' . l:bufNameFull)
       endif

   endfor " }

   call TQ84_log_dedent()
   return l:ret
endfu " }

fu! tq84#notes#omnifunc(findstart, base) " {
    call TQ84_log_indent('tq84#notes#omnifunc, findstart=' . a:findstart . ', base=' . a:base)

    if a:findstart == 1 " { First invocation
       let l:pos = col('.')
       call TQ84_log('Returning ' . l:pos . ' because findstart == 1')
       call TQ84_log_dedent()
       return l:pos
    endif " }


    call TQ84_log_dedent()

    return tq84#notes#buffers()

endfu " }

fu! tq84#notes#gotoFileUnderCursor(openInNewWindow) " {
    call TQ84_log_indent('tq84#notes#gotoFileUnderCursor')

    let l:line = getline('.')
    let l:col  = virtcol('.')
    call TQ84_log('l:line=' . l:line . ', col=' . l:col)

    let l:filename_rel = matchstr(l:line, '\v→ *\zs[-_a-zA-Zäöü/]*%' . l:col . 'v[-_a-zA-Zäöü/]*\ze')

    if l:filename_rel == ''
       call TQ84_log('l:filename_rel is empty, returning')
       call TQ84_log_dedent()
       return
    endif

    call TQ84_log('filename_rel=' . l:filename_rel)
    let l:filename_abs = $github_root . 'notes/notes/' . l:filename_rel
    call TQ84_log('filename_abs=' . l:filename_abs)

    if isdirectory(l:filename_abs) " {

       let l:last_char = tq84#string#fromEnd(l:filename_abs, 1)

       call TQ84_log('isdirectory, l:last_char = ' . l:last_char)

       if l:last_char != '/' && l:last_char != '\'
          let l:filename_abs .= '/'
       endif

       let l:filename_abs .= 'index'

    endif " }

    call TQ84_log('e ' . l:filename_abs)

    if a:openInNewWindow
       call tq84#buf#openFile(l:filename_abs) 
    else
      execute 'e ' . l:filename_abs
    end

    call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
