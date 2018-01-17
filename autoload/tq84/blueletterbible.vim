call TQ84_log_indent(expand('<sfile>'))

" Assign book_abbreviations
let s:book_abbreviations= {
  \ 'Gen' : '1mo'  ,
  \ 'Exo' : '2mo'  ,
  \ 'Lev' : '3mo'  ,
  \ 'Num' : '4mo'  ,
  \ 'Deu' : '5mo'  ,
  \ 'Jdg' : 'ri'   ,
  \ 'Rth' : 'rt'   ,
  \ '1Sa' : '1sam' ,
  \ '2Sa' : '2sam' ,
  \ '1Ki' : '1koe' ,
  \ '2Ki' : '2koe' ,
  \ '1Ch' : '1chr' ,
  \ '2Ch' : '2chr' ,
  \ 'Ezr' : 'esr'  ,
  \ 'Neh' : 'neh'  ,
  \ 'Est' : 'est'  ,
  \ 'Job' : 'hi'   ,
  \ 'Psa' : 'ps'   ,
  \ 'Pro' : 'spr'  ,
  \ 'Ecc' : 'pred' ,
  \ 'Sng' : 'hl'   ,
  \ 'Isa' : 'jes'  ,
  \ 'Jer' : 'jer'  ,
  \ 'Lam' : 'kla'  ,
  \ 'Eze' : 'hes'  ,
  \ 'Dan' : 'dan'  ,
  \ 'Hos' : 'hos'  ,
  \ 'Joe' : 'joe'  ,
  \ 'Amo' : 'am'   ,
  \ 'Oba' : 'ob'   ,
  \ 'Jon' : 'jon'  ,
  \ 'Mic' : 'mi'   ,
  \ 'Nah' : 'nah'  ,
  \ 'Hab' : 'hab'  ,
  \ 'Zep' : 'zeph' ,
  \ 'Hag' : 'hag'  ,
  \ 'Zec' : 'sach' ,
  \ 'Mal' : 'mal'  ,
  \ 'Mat' : 'mt'   ,
  \ 'Mar' : 'mk'   ,
  \ 'Luk' : 'lk'   ,
  \ 'Jhn' : 'joh'  ,
  \ 'Act' : 'apg'  ,
  \ 'Rom' : 'roem' ,
  \ '1Co' : '1kor' ,
  \ '2Co' : '2kor' ,
  \ 'Gal' : 'gal'  ,
  \ 'Eph' : 'eph'  ,
  \ 'Phl' : 'phil' ,
  \ 'Col' : 'kol'  ,
  \ '1Th' : '1thes',
  \ '2Th' : '2thes',
  \ '1Ti' : '1tim' ,
  \ '2Ti' : '2tim' ,
  \ 'Tit' : 'tit'  ,
  \ 'Phm' : 'phim' ,
  \ 'Heb' : 'hebr' ,
  \ 'Jam' : 'jak'  ,
  \ '1Pe' : '1petr',
  \ '2Pe' : '2petr',
  \ '1Jo' : '1joh' ,
  \ '2Jo' : '2joh' ,
  \ '3Jo' : '3joh' ,
  \ 'Jud' : 'jud'  ,
  \ 'Rev' : 'offb'
  \ }
 
" Create book_abbreviations_reverse {

let s:book_abbreviations_reverse ={}
for abbr_en in keys(s:book_abbreviations)
    let abbr_gr = s:book_abbreviations[abbr_en]
    call TQ84_log('abbr_en = ' . abbr_en . ', abbr_gr = ' . abbr_gr)
    let s:book_abbreviations_reverse[abbr_gr] = abbr_en

endfor
" }

fu! tq84#blueletterbible#book_abbreviation_en_to_gr(abbr_en) " {
    call TQ84_log_indent('tq84#blueletterbible#abbreviation_en_to_gr: ' . a:abbr_en)
    let  ret_=s:book_abbreviations[a:abbr_en]
    call TQ84_log('ret_ = ' . ret_)
    call TQ84_log_dedent()
    return ret_
endfu " }

fu! tq84#blueletterbible#book_abbreviation_gr_to_en(abbr_gr) " {
    call TQ84_log_indent('tq84#blueletterbible#abbreviation_en_to_gr: ' . a:abbr_gr)
    let  ret_=s:book_abbreviations_reverse[a:abbr_gr]
    call TQ84_log('ret_ = ' . ret_)
    call TQ84_log_dedent()
    return ret_
endfu " }

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
       let l:v ={'buch': s:book_abbreviations[l:matched[1]], 'kapitel': l:matched[2], 'vers': l:matched[3]}
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
