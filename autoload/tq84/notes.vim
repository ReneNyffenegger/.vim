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

       let l:leftOfCursor = tq84#buf#lineLeftOfCursor()

       call TQ84_log('l:leftOfCursor: >' . l:leftOfCursor . '<')

"      let l:matches = matchlist(l:leftOfCursor, '\v→ *(\S*)$')
"      call TQ84_log('len(l:matches)' . len(l:matches))

       let l:matchList = matchlist(l:leftOfCursor, '\v(→)? *(\S*)$')

       if len(l:matchList) == 0 " {
"         call TQ84_log("→ didnt't match" )
"         let s:omnifunc_add_arrow = 1
"         let l:pos = col('.') - 
          call TQ84_log('Returning -3 because no → found')
          call TQ84_log_dedent()
          return -3
       endif
"      else
"         let s:omnifunc_add_arrow = 0
"         let l:pos = col('.')
"      end " }

       call TQ84_log('l:matchList[1, 2, 3, 4] = ' . l:matchList[1] . ' - ' . l:matchList[2] . ' - ' . l:matchList[3] . ' - ' . l:matchList[4])

       if l:matchList[1] == '→'
          let s:omnifunc_add_arrow = 0
       else
          let s:omnifunc_add_arrow = 1
       endif

       let l:pos = col('.') - strlen(l:matchList[2]) -1

       call TQ84_log('s:omnifunc_add_arrow = ' . s:omnifunc_add_arrow)

       call TQ84_log('Returning ' . l:pos . ' because findstart == 1')
       call TQ84_log_dedent()
       return l:pos
    endif " }

    if a:base == '' " {
       call TQ84_log('returning buffers because a:base is empty')
       call TQ84_log_dedent()
       if s:omnifunc_add_arrow
          return map(tq84#notes#buffers(), "'→ ' . v:val")
       else
          return tq84#notes#buffers()
       endif
    endif " }

    let l:globbedFiles = split(glob('**/' . a:base), nr2char(0))


    call TQ84_log_dedent()
    if s:omnifunc_add_arrow
       return map(l:globbedFiles, "'→ ' . v:val")
    else
       return l:globbedFiles
    endif

endfu " }

fu! tq84#notes#gotoFileUnderCursor(openInNewWindow) " {
    call TQ84_log_indent('tq84#notes#gotoFileUnderCursor')

    let l:line = getline('.')
    let l:col  = virtcol('.')
    call TQ84_log('l:line=' . l:line . ', col=' . l:col)

    let l:matches = matchlist(l:line, '\v(→?) *([-_a-zA-Zäöü0-9/]*%' . l:col . 'v[-_a-zA-Zäöü0-9/]*)')

    let l:filename_rel = l:matches[2]

    if l:filename_rel == ''
       call TQ84_log('l:filename_rel is empty, returning')
       call TQ84_log_dedent()
       return
    endif

    if l:matches[1] != '→'
       call TQ84_log('not a → file, opening ' . l:filename_rel)
       call tq84#buf#openFile(l:filename_rel)
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
