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

       let l:matchList = matchlist(l:leftOfCursor, '\v(→)? *(\S*)$')

       if len(l:matchList) == 0 " {
          call TQ84_log('Returning -3 because no → found')
          call TQ84_log_dedent()
          return -3
       endif " }

       call TQ84_log('l:matchList[1, 2, 3, 4] = ' . l:matchList[1] . ' - ' . l:matchList[2] . ' - ' . l:matchList[3] . ' - ' . l:matchList[4])

       if l:matchList[1] == '→'
          let s:omnifunc_add_arrow = 0
       else
          let s:omnifunc_add_arrow = 1
       endif

       let s:omni_func_path_to_add_anchors = ''
       if filereadable(l:matchList[2]) " {
           let s:omni_func_path_to_add_anchors = l:matchList[2]
           call TQ84_log('return col(".") because ' . l:matchList[2] . ' is a file')
           call TQ84_log_dedent()
           return col('.')
       endif " }

       let l:pos = col('.') - strlen(l:matchList[2]) -1

       call TQ84_log('s:omnifunc_add_arrow = ' . s:omnifunc_add_arrow)

       call TQ84_log('Returning ' . l:pos . ' because findstart == 1')
       call TQ84_log_dedent()
       return l:pos
    endif " }

    call TQ84_log('s:omni_func_path_to_add_anchors=' . s:omni_func_path_to_add_anchors)
    if s:omni_func_path_to_add_anchors != '' " {

       call TQ84_log('Adding anchors')
       let l:existing_file = tq84#notes#addIndexToPathIfNecessary(s:omni_func_path_to_add_anchors)

       let l:lines_existing_file = readfile(l:existing_file)

       let l:anchors = filter(l:lines_existing_file, {i,v->match(v, '{.*#') != -1})
       let l:anchors = map(l:anchors, {i,v->matchstr(v, '{.*\zs#.*\ze *$')})

       call TQ84_log('returning anchors ' . string(l:anchors))
       call TQ84_log_dedent()
       return l:anchors

    endif " }

    if a:base == '' " {
       "
       let l:buffers = tq84#notes#buffers()

     " 2017-01-26 remove trailing /index:
       call TQ84_log('remove trailing /index')
       call map(l:buffers, "substitute(v:val, '/index$', '', '')")
"      let l:buffers = map(l:buffers, "v:val = substitute(v:val, 'o', 'XXX', 'g')")

       call TQ84_log('returning buffers because a:base is empty')
       call TQ84_log_dedent()

       if s:omnifunc_add_arrow
          return map(l:buffers, "'→ ' . v:val")
       else
          return l:buffers
       endif
    endif " }

  


    let l:globbedFiles = split(glob('**/' . a:base), nr2char(0))
  " 2017-01-26 remove trailing /index:
    call map(l:globbedFiles, "substitute(v:val, '/index$', '', '')")


    call TQ84_log_dedent()
    if s:omnifunc_add_arrow
       return map(l:globbedFiles, "'→ ' . v:val")
    else
       return l:globbedFiles
    endif

endfu " }

fu! tq84#notes#addIndexToPathIfNecessary(path) " {
  call TQ84_log_indent('tq84#notes#addIndexToPathIfNecessary, path=' . a:path)

  if isdirectory(a:path) " {

     let l:last_char = tq84#string#fromEnd(a:path, 1)

     call TQ84_log('isdirectory, l:last_char = ' . l:last_char)

     if l:last_char != '/' && l:last_char != '\'
        let a:path .= '/'
     endif

     let a:path .= 'index'

  endif " }

  call TQ84_log('returning ' . a:path)
  call TQ84_log_dedent()
  return a:path
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

    let l:filename_abs = tq84#notes#addIndexToPathIfNecessary(l:filename_abs)
"   if isdirectory(l:filename_abs) " {

"      let l:last_char = tq84#string#fromEnd(l:filename_abs, 1)

"      call TQ84_log('isdirectory, l:last_char = ' . l:last_char)

"      if l:last_char != '/' && l:last_char != '\'
"         let l:filename_abs .= '/'
"      endif

"      let l:filename_abs .= 'index'

"   endif " }

    call TQ84_log('e ' . l:filename_abs)

    if a:openInNewWindow
       call tq84#buf#openFile(l:filename_abs) 
    else
      execute 'e ' . l:filename_abs
    end

    call TQ84_log_dedent()
endfu " }

fu! tq84#notes#tabPressed() " {
  call TQ84_log_indent('tq84#notes#tabPressed')

  call tq84#buf#logLineAndPos()

  let l:found = tq84#buf#regexpAtCursor('§\+?V?\zs\w+-\d+-\d+')

  call TQ84_log('l:found=' . l:found)

  if l:found != '' " {
     let l:matchlist = matchlist(l:found, '\v(\w+)-(\d+)-(\d+)')
     call tq84#bibelkommentare#gotoVerseFromAnywhere({'buch': l:matchlist[1], 'kapitel': l:matchlist[2], 'vers': l:matchlist[3]})
  endif " }

  call TQ84_log_dedent()
endfu " }

fu! tq84#notes#bibleVerse() " {
  call TQ84_log_indent('tq84#notes#bibleVerse')
  let l:bcv  = Bibel#EingabeBuchKapitelVers()

  if l:bcv =={}
     call TQ84_log('Nichts eingegeben')
     call TQ84_log_dedent()
     return ''
  endif

  let l:text = Bibel#VersText(l:bcv, 'eue')

  let l:text .= ' §' . l:bcv['buch'] . '-' . l:bcv['kapitel'] . '-' . l:bcv['vers']

  call TQ84_log_dedent()
  return l:text
endfu " }

call TQ84_log_dedent()
