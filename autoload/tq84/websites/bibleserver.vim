call TQ84_log_indent(expand('<sfile>'))

fu! tq84#websites#bibleserver#openLuther2017(verse) " {
  call TQ84_log_indent('tq84#websites#bibleserver#openLuther2017 ' . string(a:verse))

  if a:verse=={}
     call TQ84_log('verse={}, returning')
     call TQ84_log_dedent()
     return
  endif

  let l:buchname = Bibel#BuchnameAusAbkuerzung(a:verse['buch'])
  call TQ84_log('l:buchname = ' . l:buchname) 
  call OpenUrl#Go('http://www.bibleserver.com/text/LUT/' . l:buchname . '/' . a:verse['kapitel'] . ',' . a:verse['vers'])

  call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
