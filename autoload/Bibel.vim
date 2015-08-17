call TQ84_log_indent(expand("<sfile>"))

fu! Bibel#BuchnameAusAbkuerzung(abkuerzung) " {
  call TQ84_log_indent(expand("<sfile>") . ' abkuerzung: ' . a:abkuerzung)

  if     a:abkuerzung == '1mo'   | let l:ret = '1. Mose'
  elseif a:abkuerzung == '2mo'   | let l:ret = '2. Mose'
  elseif a:abkuerzung == '3mo'   | let l:ret = '3. Mose'
  elseif a:abkuerzung == '4mo'   | let l:ret = '4. Mose'
  elseif a:abkuerzung == '5mo'   | let l:ret = '5. Mose'
  elseif a:abkuerzung == 'jos'   | let l:ret = 'Josua'
  elseif a:abkuerzung == 'ri'    | let l:ret = 'Richter'
  elseif a:abkuerzung == 'rt'    | let l:ret = 'Ruth'
  elseif a:abkuerzung == '1sam'  | let l:ret = '1. Samuel'
  elseif a:abkuerzung == '2sam'  | let l:ret = '2. Samuel'
  elseif a:abkuerzung == '1koe'  | let l:ret = '1. Könige'
  elseif a:abkuerzung == '2koe'  | let l:ret = '2. Könige'
  elseif a:abkuerzung == '1chr'  | let l:ret = '1. Chronik'
  elseif a:abkuerzung == '2chr'  | let l:ret = '2. Chronik'
  elseif a:abkuerzung == 'esr'   | let l:ret = 'Esra'
  elseif a:abkuerzung == 'neh'   | let l:ret = 'Nehemia'
  elseif a:abkuerzung == 'est'   | let l:ret = 'Esther'
  elseif a:abkuerzung == 'hi'    | let l:ret = 'Hiob'
  elseif a:abkuerzung == 'ps'    | let l:ret = 'Psalm'
  elseif a:abkuerzung == 'spr'   | let l:ret = 'Sprüche'
  elseif a:abkuerzung == 'pred'  | let l:ret = 'Prediger'
  elseif a:abkuerzung == 'hl'    | let l:ret = 'Hohelied'
  elseif a:abkuerzung == 'jes'   | let l:ret = 'Jesaja'
  elseif a:abkuerzung == 'jer'   | let l:ret = 'Jeremia'
  elseif a:abkuerzung == 'kla'   | let l:ret = 'Klagelieder'
  elseif a:abkuerzung == 'hes'   | let l:ret = 'Hesekiel'
  elseif a:abkuerzung == 'dan'   | let l:ret = 'Daniel'
  elseif a:abkuerzung == 'hos'   | let l:ret = 'Hosea'
  elseif a:abkuerzung == 'jo'    | let l:ret = 'Joel'
  elseif a:abkuerzung == 'am'    | let l:ret = 'Amos'
  elseif a:abkuerzung == 'ob'    | let l:ret = 'Obadja'
  elseif a:abkuerzung == 'jon'   | let l:ret = 'Jona'
  elseif a:abkuerzung == 'mi'    | let l:ret = 'Micha'
  elseif a:abkuerzung == 'nah'   | let l:ret = 'Nahum'
  elseif a:abkuerzung == 'hab'   | let l:ret = 'Habakuk'
  elseif a:abkuerzung == 'zeph'  | let l:ret = 'Zephanja'
  elseif a:abkuerzung == 'hag'   | let l:ret = 'Haggai'
  elseif a:abkuerzung == 'sach'  | let l:ret = 'Sacharja'
  elseif a:abkuerzung == 'mal'   | let l:ret = 'Maleachi'
  elseif a:abkuerzung == 'mt'    | let l:ret = 'Matthäus'
  elseif a:abkuerzung == 'mk'    | let l:ret = 'Markus'
  elseif a:abkuerzung == 'lk'    | let l:ret = 'Lukas'
  elseif a:abkuerzung == 'joh'   | let l:ret = 'Johannes'
  elseif a:abkuerzung == 'apg'   | let l:ret = 'Apostelgeschichte'
  elseif a:abkuerzung == 'roem'  | let l:ret = 'Römer'
  elseif a:abkuerzung == '1kor'  | let l:ret = '1. Korinther'
  elseif a:abkuerzung == '2kor'  | let l:ret = '2. Korinther'
  elseif a:abkuerzung == 'gal'   | let l:ret = 'Galater'
  elseif a:abkuerzung == 'eph'   | let l:ret = 'Epheser'
  elseif a:abkuerzung == 'phil'  | let l:ret = 'Philipper'
  elseif a:abkuerzung == 'kol'   | let l:ret = 'Kolosser'
  elseif a:abkuerzung == '1thes' | let l:ret = '1. Thessaloniker'
  elseif a:abkuerzung == '2thes' | let l:ret = '2. Thessaloniker'
  elseif a:abkuerzung == '1tim'  | let l:ret = '1. Timotheus'
  elseif a:abkuerzung == '2tim'  | let l:ret = '2. Timotheus'
  elseif a:abkuerzung == 'tit'   | let l:ret = 'Titus'
  elseif a:abkuerzung == 'phil'  | let l:ret = 'Philemon'
  elseif a:abkuerzung == 'hebr'  | let l:ret = 'Hebräer'
  elseif a:abkuerzung == 'jak'   | let l:ret = 'Jakobus'
  elseif a:abkuerzung == '1petr' | let l:ret = '1. Petrus'
  elseif a:abkuerzung == '2petr' | let l:ret = '2. Petrus'
  elseif a:abkuerzung == '1joh'  | let l:ret = '1. Johannes'
  elseif a:abkuerzung == '2joh'  | let l:ret = '2. Johannes'
  elseif a:abkuerzung == '3joh'  | let l:ret = '3. Johannes'
  elseif a:abkuerzung == 'jud'   | let l:ret = 'Judas'
  elseif a:abkuerzung == 'offb'  | let l:ret = 'Offenbarung'
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
