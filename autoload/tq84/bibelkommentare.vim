call TQ84_log_indent(expand('<sfile>'))

fu! tq84#bibelkommentare#searchVerse(bkv) " {
  call TQ84_log_indent('bibelkommentare#searchVerse')

" let bkv = Bibel#EingabeBuchKapitelVers()

  let l:pattern = '^#' . a:bkv['buch'] . '-' . a:bkv['kapitel'] . '-' . a:bkv['vers'] . ' {'
  call TQ84_log('searching for ' . l:pattern)
  let l:lineNo = search(l:pattern, 'w')
  
  call TQ84_log('l:lineNo = ' . l:lineNo) 

  call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
