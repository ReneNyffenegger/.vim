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

fu! Bibel#EingabeBuchKapitelVers() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:found = 0

  while ! l:found

    try " Detect CTRL-C while inputtning Buch, Kapitel und Vers {
      let l:buch_kapitel_vers  = input("Buch Kapitel Vers: ")
    catch /^Vim:Interrupt$/
      call TQ84_log('CTRL-C wurde betätigt')
      call TQ84_log_dedent()
      return {}
    endtry " }

    call TQ84_log('l:buch_kapitel_vers: ' . l:buch_kapitel_vers)
    let l:buch_kapitel_vers_ = matchlist(l:buch_kapitel_vers, '\v(\w+) (\w+) (\S+)')

    if has_key(s:Buecher, l:buch_kapitel_vers_[1])
       let l:found = 1
    endif

  endwhile

  let l:ret = {
     \ 'buch'   : buch_kapitel_vers_[1],
     \ 'kapitel': buch_kapitel_vers_[2],
     \ 'vers'   : buch_kapitel_vers_[3]}

  cal TQ84_log('ret = ' . string(l:ret))
  
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

fu! Bibel#VersText(vers) " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:text = ''
  
  if ! exists('s:eigene_uebersetzung')
     let s:eigene_uebersetzung = readfile($git_work_dir . '/biblisches/kommentare/eigene_uebersetzung.txt')
  endif

  let l:verse = matchlist(a:vers['vers'], '\v^(\d+)-(\d+)')

  call TQ84_log('len(verse) = ' .len(l:verse))
  if len(l:verse) > 1
     let l:start_vers = l:verse[1]
     let l:end_vers   = l:verse[2]
  else
     let l:start_vers = a:vers['vers']
     let l:end_vers   = a:vers['vers']
  endif   
  call TQ84_log('start_vers: ' . l:start_vers . ', end_vers: ' . l:end_vers)

  let l:additional_lines = 0
  for i in s:eigene_uebersetzung

    if (i =~# '^' . a:vers['buch'] . '-' . a:vers['kapitel'] . '-' . l:start_vers) || l:additional_lines

       call TQ84_log('matched, additional_lines=' . l:additional_lines . ' / ' . i)

       if len(l:text)
          let l:text = l:text . ' '
       endif

       let l:text = l:text . substitute(i, '\v.*\|(.*)\|.*', '\1', '')

       if l:additional_lines == 0
          let l:additional_lines = l:end_vers - l:start_vers + 1
          call TQ84_log('initializing additional_lines to: ' . l:additional_lines)
       endif


       let l:additional_lines = l:additional_lines - 1

       if l:additional_lines <= 0
          call TQ84_log_dedent()
          return l:text
       endif

    endif

  endfor

  call TQ84_log_dedent()
  return 'Not found'
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

call TQ84_log_dedent()
