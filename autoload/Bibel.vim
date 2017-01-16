call TQ84_log_indent(expand("<sfile>"))

let s:Buecher = {
\   '1mo'   : {'Name': '1. Mose'          }, 
\   '2mo'   : {'Name': '2. Mose'          }, 
\   '3mo'   : {'Name': '3. Mose'          }, 
\   '4mo'   : {'Name': '4. Mose'          }, 
\   '5mo'   : {'Name': '5. Mose'          }, 
\   'jos'   : {'Name': 'Josua'            }, 
\   'ri'    : {'Name': 'Richter'          }, 
\   'rt'    : {'Name': 'Ruth'             }, 
\   '1sam'  : {'Name': '1. Samuel'        }, 
\   '2sam'  : {'Name': '2. Samuel'        }, 
\   '1koe'  : {'Name': '1. Könige'        }, 
\   '2koe'  : {'Name': '2. Könige'        }, 
\   '1chr'  : {'Name': '1. Chronik'       }, 
\   '2chr'  : {'Name': '2. Chronik'       }, 
\   'esr'   : {'Name': 'Esra'             }, 
\   'neh'   : {'Name': 'Nehemia'          }, 
\   'est'   : {'Name': 'Esther'           }, 
\   'hi'    : {'Name': 'Hiob'             }, 
\   'ps'    : {'Name': 'Psalm'            },
\   'spr'   : {'Name': 'Sprüche'          },
\   'pred'  : {'Name': 'Prediger'         },
\   'hl'    : {'Name': 'Hohelied'         },
\   'jes'   : {'Name': 'Jesaja'           },
\   'jer'   : {'Name': 'Jeremia'          },
\   'kla'   : {'Name': 'Klagelieder'      },
\   'hes'   : {'Name': 'Hesekiel'         },
\   'dan'   : {'Name': 'Daniel'           },
\   'hos'   : {'Name': 'Hosea'            },
\   'joe'   : {'Name': 'Joel'             },
\   'am'    : {'Name': 'Amos'             },
\   'ob'    : {'Name': 'Obadja'           },
\   'jon'   : {'Name': 'Jona'             },
\   'mi'    : {'Name': 'Micha'            },
\   'nah'   : {'Name': 'Nahum'            },
\   'hab'   : {'Name': 'Habakuk'          },
\   'zeph'  : {'Name': 'Zephanja'         },
\   'hag'   : {'Name': 'Haggai'           },
\   'sach'  : {'Name': 'Sacharja'         },
\   'mal'   : {'Name': 'Maleachi'         },
\   'mt'    : {'Name': 'Matthäus'         },
\   'mk'    : {'Name': 'Markus'           },
\   'lk'    : {'Name': 'Lukas'            },
\   'joh'   : {'Name': 'Johannes'         },
\   'apg'   : {'Name': 'Apostelgeschichte'},
\   'roem'  : {'Name': 'Römer'            },
\   '1kor'  : {'Name': '1. Korinther'     },
\   '2kor'  : {'Name': '2. Korinther'     },
\   'gal'   : {'Name': 'Galater'          },
\   'eph'   : {'Name': 'Epheser'          },
\   'phil'  : {'Name': 'Philipper'        },
\   'kol'   : {'Name': 'Kolosser'         },
\   '1thes' : {'Name': '1. Thessaloniker' },
\   '2thes' : {'Name': '2. Thessaloniker' },
\   '1tim'  : {'Name': '1. Timotheus'     },
\   '2tim'  : {'Name': '2. Timotheus'     },
\   'tit'   : {'Name': 'Titus'            },
\   'phim'  : {'Name': 'Philemon'         },
\   'hebr'  : {'Name': 'Hebräer'          },
\   'jak'   : {'Name': 'Jakobus'          },
\   '1petr' : {'Name': '1. Petrus'        },
\   '2petr' : {'Name': '2. Petrus'        },
\   '1joh'  : {'Name': '1. Johannes'      },
\   '2joh'  : {'Name': '2. Johannes'      },
\   '3joh'  : {'Name': '3. Johannes'      },
\   'jud'   : {'Name': 'Judas'            },
\   'offb'  : {'Name': 'Offenbarung'      },
\ }

let s:uebersetzung = {}
let s:github_uebersetzungen_pfad = expand("$github_root") . '/Bibeluebersetzungen'

fu! Bibel#ResetBuchCache(uebersetzung) " {
  call TQ84_log_indent(expand('<sfile>'))

  if has_key(s:uebersetzung, a:uebersetzung)
     call remove(s:uebersetzung, a:uebersetzung)
  endif

  call TQ84_log_dedent()
endfu " }

fu! Bibel#EingabeBuchKapitelVers() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:found = 0

  while ! l:found " Iterieren, bis gültige Eingabe (oder nichts) eingegeben wurde {

    try " Catch CTRL-C {
      let l:buch_kapitel_vers  = input("Buch Kapitel Vers: ")
    catch /^Vim:Interrupt$/
      call TQ84_log('CTRL-C gedrückt')
      let l:buch_kapitel_vers = ''
    endtry " }

    if l:buch_kapitel_vers == '' " { Leeren Hash zurückgeben, wenn nichts eingegeben
      call TQ84_log('Nichts eingegeben')
      call TQ84_log_dedent()
    " 2017-01-16 returning empty Dictionary instead of nothing, so that
    "            returned value can be compared  with == {}
      return {}
    endif " }

    call TQ84_log('l:buch_kapitel_vers: ' . l:buch_kapitel_vers)
    let l:buch_kapitel_vers_ = matchlist(l:buch_kapitel_vers, '\v(\w+) (\w+) (\S+)')

    call TQ84_log('len(l:buch_kapitel_vers_): ' . len(l:buch_kapitel_vers_))

    if len(l:buch_kapitel_vers_) == 10 " Matchlist seems to return 10 items if it matched...
       if has_key(s:Buecher, l:buch_kapitel_vers_[1])
          let l:found = 1
       endif
    endif

  endwhile " }

  let l:ret = {
     \ 'buch'   : buch_kapitel_vers_[1],
     \ 'kapitel': buch_kapitel_vers_[2],
     \ 'vers'   : buch_kapitel_vers_[3]}

  call TQ84_log('ret = ' . string(l:ret))
  
  call TQ84_log_dedent()

  return l:ret
endfu " }

fu! Bibel#BuchnameAusAbkuerzung(abkuerzung) " {
  call TQ84_log_indent(expand("<sfile>") . ' abkuerzung: ' . a:abkuerzung)

  if has_key(s:Buecher, a:abkuerzung)
     let l:ret = s:Buecher[a:abkuerzung]['Name']
  else
     let l:ret = 'Kein Buch mit Abkürzung ' . a:abkuerzung
  endif

  call TQ84_log('Buchname für Abkürzung: ' . l:ret)
  call TQ84_log_dedent()

  return l:ret

endfu " }

fu! Bibel#Vers(vers) " {
  call TQ84_log_indent(expand('<sfile>'))

  echo 'Use Bibel#VersText instead of Bibel#Vers'
  call TQ84_log('Use VersText instead of Bibel#Vers')
  
  if ! exists('s:eigene_uebersetzung')
     let s:eigene_uebersetzung = readfile($git_work_dir . '/biblisches/kommentare/eigene_uebersetzung.txt')
  endif

  for i in s:eigene_uebersetzung

    if i =~# '^' . a:vers['buch'] . '-' . a:vers['kapitel'] . '-' . a:vers['vers']

       let l:text = substitute(i, '\v.*\|(.*)\|.*', '\1', '')
       call TQ84_log_dedent()
       return l:text
    endif

  endfor

  call TQ84_log_dedent()
  return 'Not found'
endfu " }

fu! Bibel#UebersetzungEinlesen(uebersetzung) " {
  call TQ84_log_indent(expand('<sfile>') . ' a:uebersetzung = ' . a:uebersetzung)

  let l:pfad = Bibel#PfadTextDatei(a:uebersetzung)
  call TQ84_log('l:pfad = ' . l:pfad)

  let l:file = readfile(l:pfad)

  let l:ret = {}

  let l:line_no = 0
  try
  for l:line in l:file " {

    let l:line_no = l:line_no + 1

    let l:m = matchlist(l:line, '\v^([^-]+)-([^-]+)-([^|]+)\|([^|]+)\|')

    if l:line =~# '^#'
       continue
    endif

    if ! has_key(l:ret, l:m[1])
       let l:ret[l:m[1]] = {}
    endif

    if ! has_key(l:ret[l:m[1]], l:m[2])
       let l:ret[l:m[1]][l:m[2]] = {}
    endif

    let l:ret[l:m[1]][l:m[2]][l:m[3]] = l:m[4]

  endfor " }
  catch /.*/
    let l:fehler = 'Fehler in ' . l:pfad . ', Zeile: ' . l:line_no . ' (' . v:exception . ')'
    call TQ84_log(l:fehler)
    echo 'Bibel#UebersetzungEinlesen: ' . l:fehler
  endtry

  call TQ84_log_dedent()
  return l:ret
endfu " }

fu! Bibel#VersText(vers, uebersetzung) " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:text = ''

  if ! has_key(s:uebersetzung, a:uebersetzung)
     let s:uebersetzung[a:uebersetzung] = Bibel#UebersetzungEinlesen(a:uebersetzung)
  endif

  let l:uebersetzung = s:uebersetzung[a:uebersetzung]

  if     type(a:vers) == 1 " { String
    call TQ84_log('Typ ist String')
    let l:buch_kapitel_vers = matchlist(a:vers, '\v([^-]+)-([^-]+)-(\S+)')
    let l:vers = {
       \ 'buch'   : l:buch_kapitel_vers[1],
       \ 'kapitel': l:buch_kapitel_vers[2],
       \ 'vers'   : l:buch_kapitel_vers[3]}

    call TQ84_log('l:vers = ' .string(l:vers))

  " }
  elseif type(a:vers) == 4 " { Hash
    call TQ84_log('Typ ist Hash')
    let l:vers = a:vers
  endif " }

  let l:verse = matchlist(l:vers['vers'], '\v^(\d+)-(\d+)')

  call TQ84_log('len(verse) = ' .len(l:verse))
  if len(l:verse) > 1
     let l:start_vers = l:verse[1]
     let l:end_vers   = l:verse[2]
  else
     let l:start_vers = l:vers['vers']
     let l:end_vers   = l:vers['vers']
  endif   
  call TQ84_log('start_vers: ' . l:start_vers . ', end_vers: ' . l:end_vers)

  let l:additional_lines = 0

  if ! has_key(l:uebersetzung[l:vers['buch']][l:vers['kapitel']], l:end_vers)

     call TQ84_log_dedent()
     return 'Vers ' . l:end_vers . ' nicht vorhanden'

  endif

  let l:text = ''
  for l:vers_ in range(l:start_vers, l:end_vers) " { Über Verse iterieren

    if len(l:text)
       let l:text = l:text . ' '
    endif

    if has_key(l:uebersetzung[l:vers['buch']][l:vers['kapitel']], l:vers_)
 
       let l:text = l:text . l:uebersetzung[l:vers['buch']][l:vers['kapitel']][l:vers_]

    else

       let l:text = l:text . ' *** Vers ' . l:vers_ . " gibt's nicht ***"

    endif

  endfor " }

  call TQ84_log_dedent()
  return l:text

endfu " }

fu! Bibel#VersTexte(verse, uebersetzungen) " {

    "
    "  Aufruf
    "     call Bibel#VersTexte('2mo-4-9 jes-8-12', 'eue elb1905 kjv')
    "
    "  Erstellt ein neues Window (new) und schreibt die Verse
    "  in dieses Window.
  
    call TQ84_log_indent(expand('<sfile>'))
    
    new

    for l:vers in split(a:verse)
      call TQ84_log('l:vers = ' . l:vers)
      call append('$', l:vers)
      for l:uebersetzung in split(a:uebersetzungen)
        call TQ84_log('l:uebersetzung = ' . l:uebersetzung)
        call append('$', '  ' . Bibel#VersText(l:vers, l:uebersetzung))
      endfor

      call append('$','')

    endfor

    call TQ84_log_dedent()

endfu " }

fu! Bibel#VersID(vers) " {
  call TQ84_log_indent(expand('<sfile>'))
  

" Ersten Buchstaben des Buches gross machen
"   1mo  -> 1Mo
"   roem -> Roem
"   gal  -> Gal
  let l:ret = substitute(a:vers['buch'], '\v([a-z])', '\U\1', '')

" Allfällige führende Ziffer mit Punkt und Space
" erweitern
"
"   1Mo   -> 1. Mo
"   Roem  -> Roem
"   Gal   -> Gal

  let l:ret = substitute(l:ret, '\v(\d)', '\1. ', '')

"  oe nach ö konvertierten ausser für «joe»
"    Roem -> Röm
"    Joe  -> Joe

  if l:ret != 'Joe'
     let l:ret = substitute(l:ret, 'oe', 'ö', '')
  endif

" Kapitel und Vers anhängen

  let l:ret = l:ret . ' ' . a:vers['kapitel'] . ':' . a:vers['vers']

  call TQ84_log('l:ret = ' . l:ret)

  call TQ84_log_dedent()
  return l:ret
endfu " }

fu! Bibel#PfadTextDatei(uebersetzung) " {

  call TQ84_log_indent(expand('<sfile>') . ' ' . a:uebersetzung)

  if     a:uebersetzung ==# 'eue'
"        let l:ret = $git_work_dir . '/biblisches/kommentare/uebersetzungen/tq84.bibel'
         let l:ret = s:github_uebersetzungen_pfad . '/tq84.bibel'
  elseif a:uebersetzung ==# 'kjv'
         let l:ret = s:github_uebersetzungen_pfad . '/kjv.bibel'
  elseif a:uebersetzung ==# 'elb1905'
         let l:ret = s:github_uebersetzungen_pfad . '/elb1905.bibel'
  elseif a:uebersetzung ==# 'sch2k'
         let l:ret = $git_work_dir . '/biblisches/kommentare/uebersetzungen/sch2k.bibel'
  elseif a:uebersetzung ==# 'ylt'
         let l:ret = s:github_uebersetzungen_pfad . '/ylt.bibel'
  elseif a:uebersetzung ==# 'jantz'
         let l:ret = $digitales_backup . 'Biblisches/Uebersetzungen/Jantzen_Das_Neue_Testament_In_Deutscher_Fassung_2011.txt'
  else
         call TQ84_log('Unbekannte Übersetzung ' . a:uebersetzung)
         call TQ84_log_dedent()
         throw 'Unbekannte Übersetzung ' . a:uebersetzung
  endif

  call TQ84_log('Returning ' . l:ret)
  call TQ84_log_dedent()
  return l:ret

endfu " }

fu! Bibel#ZeigeVerseMitEingabe(uebersetzung) " {
  call TQ84_log_indent(expand('<sfile>'))
  let l:vers = Bibel#EingabeBuchKapitelVers()


  if l:vers == {}
     call TQ84_log_dedent()
     return
   endif

   echo "\n"
   echo Bibel#VersText(l:vers, a:uebersetzung)

  call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
