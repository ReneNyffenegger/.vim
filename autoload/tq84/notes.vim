call TQ84_log_indent(expand('<sfile>'))

fu! tq84#notes#buffers() " {
   call TQ84_log_indent('tq84#notes#buffers')

   let l:ret = []

   for l:bufName in tq84#buf#buffers() " {

       if !len(l:bufName)
          call TQ84_log('bufName is empty, skipping')
          break
       endif
       
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

call TQ84_log_dedent()
