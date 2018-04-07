call TQ84_log_indent(expand('<sfile>'))

let s:book_abbreviations={
  \ '1mo'  : 'genesis',
  \ '2mo'  : 'exodus',
  \ '3mo'  : 'leviticus',
  \ '4mo'  : 'numbers',
  \ '5mo'  : 'deuteronomy',
  \ '1chr' : '1_chronicles',
  \ '2chr' : '2_chronicles',
  \ 'neh'  : 'nehemiah',
  \ 'jes'  : 'isaiah',
  \ 'jer'  : 'jeremiah',
  \ 'hi'   : 'job',
  \ 'am'   : 'amos',
  \ 'hab'  : 'habakkuk',
  \ 'hag'  : 'haggai',
  \ 'sach' : 'zechariah',
  \ 'mal'  : 'malachi',
  \ 'mt'   : 'matthew',
  \ 'mk'   : 'mark',
  \ 'lk'   : 'luke',
  \ 'joh'  : 'john',
  \ 'apg'  : 'acts',
  \ 'roem' : 'romans',
  \ 'gal'  : 'galatians',
  \ '1thes': '1_thessalonians',
  \ '2thes': '2_thessalonians',
  \ 'hebr' : 'hebrews',
  \ '1petr': '1_peter',
  \ '2petr': '2_peter',
  \ '1joh' : '1_john',
  \ '2joh' : '2_john',
  \ '3joh' : '3_john',
  \ }

fu! tq84#websites#biblehub#openInterlinearVerse(verse) " {
  call TQ84_log_indent('tq84#websites#biblehub#openInterlinearVerse ' . string(a:verse))

  if a:verse=={}
     call TQ84_log('verse={}, returning')
     call TQ84_log_dedent()
     return
  endif

  let l:buch = s:book_abbreviations[a:verse['buch']]

  call OpenUrl#Go('http://biblehub.com/interlinear/' . l:buch . '/' . a:verse['kapitel'] . '-' . a:verse['vers'] . '.htm')

  call TQ84_log_dedent()
endfu " }

fu! tq84#websites#biblehub#openCommentaries(verse) " {
  call TQ84_log_indent('tq84#websites#biblehub#openCommentaries ' . string(a:verse))

  if a:verse=={}
     call TQ84_log('verse={}, returning')
     call TQ84_log_dedent()
     return
  endif

  let l:buch = s:book_abbreviations[a:verse['buch']]

  call OpenUrl#Go('http://biblehub.com/commentaries/' . l:buch . '/' . a:verse['kapitel'] . '-' . a:verse['vers'] . '.htm')

  call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
