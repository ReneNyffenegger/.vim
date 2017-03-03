call TQ84_log_indent(expand('<sfile>'))

let s:book_abbreviations={
  \ '1mo' : 'genesis',
  \ '2mo' : 'exodus',
  \ '3mo' : 'leviticus',
  \ '4mo' : 'numbers',
  \ '5mo' : 'deuteronomy',
  \ '1chr': '1_chronicles',
  \ '2chr': '2_chronicles',
  \ 'neh' : 'nehemiah',
  \ 'mt'  : 'matthew',
  \ 'mk'  : 'mark',
  \ 'lk'  : 'lucas',
  \ 'joh' : 'john',
  \ }

fu! tq84#websites#biblehub#openInterlinearVerse(verse) " {
  call TQ84_log_indent('tq84#biblehub#openInterlinearVerse ' . string(a:verse))

  if a:verse=={}
     call TQ84_log('verse={}, returning')
     call TQ84_log_dedent()
     return
  endif

  let l:buch = s:book_abbreviations[a:verse['buch']]

  call OpenUrl#Go('http://biblehub.com/interlinear/' . l:buch . '/' . a:verse['kapitel'] . '-' . a:verse['vers'] . '.htm')

  call TQ84_log_dedent()
endfu

call TQ84_log_dedent()
