call TQ84_log_indent(expand('<sfile>'))

let s:book_abbreviations={
  \ 'Gen' : '1mo' ,
  \ 'Exo' : '2mo' ,
  \ 'Lev' : '3mo' ,
  \ 'Num' : '4mo' ,
  \ 'Deu' : '5mo' ,
  \ 'Psa' : 'ps'  ,
  \ 'Pro' : 'spr' ,
  \ 'Eze' : 'hes' ,
  \ 'Mar' : 'mk'  ,
  \ 'Rom' : 'roem',
  \ '1Co' : '1kor',
  \ '2Co' : '2kor',
  \ 'Gal' : 'gal',
  \ 'Eph' : 'eph' ,
  \ 'Col' : 'kol' ,
  \ '1Ti' : '1tim',
  \ '2Ti' : '2tim',
  \ 'Heb' : 'hebr',
  \ '1Pe' : '1petr',
  \ '2Pe' : '2petr',
  \ 'Rev' : 'offb'
  \ }



fu! tq84#blueletterbible#copied2germanText() range " {
"
" Mapping: ,bl2tx
"
" Copy the result page of a strong number's search into
" a buffer and range-call this function.
" It will extract the bible verses (eg Mar 2:14) and
" display the german text instead.
"

  call TQ84_log_indent('tq84#blueletterbible#copied2germanText ' . a:firstline . '-' . a:lastline)

  let l:found_verses = []

  let l:last_verse ={}

  for l:line_no in range(a:firstline, a:lastline)

    let l:line = getline(l:line_no)

    let l:matched = matchlist(l:line, '\v(\w+) (\d+):(\d+)')

    if len(l:matched) > 0
       let l:v = {'buch': s:book_abbreviations[l:matched[1]], 'kapitel': l:matched[2], 'vers': l:matched[3]}
       call TQ84_log('matched: ' . string(l:v))
       if l:last_verse != l:v
          call add(l:found_verses, l:v)
          let l:last_verse = l:v
       endif
    endif

  endfor

  execute a:firstline . ',' . a:lastline . ' d'

  for l:verse in l:found_verses
    call TQ84_log('l:verse=' . string(l:verse))
    let l:vers_text = Bibel#VersText(l:verse, 'eue')
    call TQ84_log('l:vers_text=' . l:vers_text)
    call append(line('.'), l:verse['buch'] . '-' . l:verse['kapitel'] . '-' . l:verse['vers'] . ': ' . l:vers_text)
    normal j
  endfor

  call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
