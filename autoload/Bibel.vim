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
\   'jo'    : {'Name': 'Joel'             },
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
    let l:buch_kapitel_vers  = input("Buch Kapitel Vers: ")
    let l:buch_kapitel_vers_ = matchlist(l:buch_kapitel_vers, '\v(\w+) (\w+) (\w+)')

    if has_key(s:Buecher, l:buch_kapitel_vers_[1])
       let l:found = 1
    endif

  endwhile

  let l:ret = {
     \ 'buch'   : buch_kapitel_vers_[1],
     \ 'kapitel': buch_kapitel_vers_[2],
     \ 'vers'   : buch_kapitel_vers_[3]}
  
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
  
  if ! exists('s:eigene_uebersetzung')
     let s:eigene_uebersetzung = readfile($git_work_dir . '/biblisches/kommentare/eigene_uebersetzung.txt')
  endif

  for i in s:eigene_uebersetzung

    if i =~# '^' . a:vers['buch'] . '-' . a:vers['kapitel'] . '-' . a:vers['vers']

"      let l:text = substitute(i, '\v.{-}\|(.{-})\|.*', '\1', '')
       let l:text = substitute(i, '\v.*\|(.*)\|.*', '\1', '')
       call TQ84_log_dedent()
       return l:text
    endif

  endfor

  call TQ84_log_dedent()
  return 'Not found'
endfu " }

call TQ84_log_dedent()
