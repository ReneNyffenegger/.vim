"
"  TODO:
"  https://github.com/tyru/open-browser.vim/blob/master/plugin/openbrowser.vim
"

call TQ84_log_indent(expand("<sfile>"))

fu! OpenUrl#Go(url) " {

  call TQ84_log_indent(expand("<sfile>") . " " . a:url)
  let use_mozilla = 1


  let l:url = a:url

  if !has('unix')
     let l:url = substitute(l:url, '#', '\\#', 'g')
     let l:url = substitute(l:url, '&', '^&' , 'g')
  else
     let l:url = substitute(l:url, '#', '\\\#'  , 'g')
     let l:url = substitute(l:url, '&', '\\&' , 'g')
"    let l:url = substitute(l:url, '~', '\\~' , 'g')
  endif

  call TQ84_log("url = " . l:url)

  
  if use_mozilla == 1
    if has('unix')
      let l:exec_stmt = "firefox -url '" . l:url . "' &"
    else
      let l:exec_stmt = "start cmd /c start firefox -url " . l:url
    endif
  else
    let l:exec_stmt = "start cmd /c start chrome  " . l:url
  endif

  call TQ84_log("exec_stmt = " . l:exec_stmt)
  execute "silent !" . l:exec_stmt

  call TQ84_log_dedent()

endfu " }

fu! OpenUrl#GoogleSearch(txt) " {

  call TQ84_log_indent(expand("<sfile>") . " " . a:txt)

  let l:q = substitute(a:txt, '\v\s+', '+', 'g')

  call TQ84_log('l:q = ' + l:q)

  call OpenUrl#Go('www.google.com/search?q=' . l:q)

  call TQ84_log_dedent()

endfu " }

fu! OpenUrl#BlueLetter(vers) " {
  call TQ84_log_indent(expand("<sfile>"))


  let l:buch    = a:vers['buch']

  if     l:buch == '1mo'   | let l:buch = 'gen'
  elseif l:buch == '2mo'   | let l:buch = 'exo'
  elseif l:buch == '3mo'   | let l:buch = 'lev'
  elseif l:buch == '4mo'   | let l:buch = 'num'
  elseif l:buch == '5mo'   | let l:buch = 'deu'
  elseif l:buch == 'ri'    | let l:buch = 'jdg'
  elseif l:buch == 'rt'    | let l:buch = 'rth'
  elseif l:buch == '1sam'  | let l:buch = '1sa'
  elseif l:buch == '2sam'  | let l:buch = '2sa'
  elseif l:buch == '1koe'  | let l:buch = '1ki'
  elseif l:buch == '2koe'  | let l:buch = '2ki'
  elseif l:buch == '1chr'  | let l:buch = '1ch'
  elseif l:buch == '2chr'  | let l:buch = '2ch'
  elseif l:buch == 'esr'   | let l:buch = 'ezr'
  elseif l:buch == 'hi'    | let l:buch = 'job'
  elseif l:buch == 'ps'    | let l:buch = 'psa'
  elseif l:buch == 'pred'  | let l:buch = 'ecc'
  elseif l:buch == 'hl'    | let l:buch = 'sng'
  elseif l:buch == 'kla'   | let l:buch = 'lam'
  elseif l:buch == 'hes'   | let l:buch = 'eze'
  elseif l:buch == 'spr'   | let l:buch = 'pro'
  elseif l:buch == 'am'    | let l:buch = 'amo'
  elseif l:buch == 'ob'    | let l:buch = 'oba'
  elseif l:buch == 'mi'    | let l:buch = 'mic'
  elseif l:buch == 'zeph'  | let l:buch = 'zep'
  elseif l:buch == 'roem'  | let l:buch = 'rom'
  elseif l:buch == 'apg'   | let l:buch = 'acts'
  elseif l:buch == '1kor'  | let l:buch = '1co'
  elseif l:buch == '2kor'  | let l:buch = '2co'
  elseif l:buch == '1petr' | let l:buch = '1pe'
  elseif l:buch == '2petr' | let l:buch = '2pe'
  elseif l:buch == 'kol'   | let l:buch = 'col'
  elseif l:buch == 'phil'  | let l:buch = 'phl'
  elseif l:buch == 'phil'  | let l:buch = 'phl'
  elseif l:buch == '1thes' | let l:buch = '1th'
  elseif l:buch == '2thes' | let l:buch = '2th'
  elseif l:buch == '1tim'  | let l:buch = '1ti'
  elseif l:buch == '2tim'  | let l:buch = '2ti'
  elseif l:buch == 'jak'   | let l:buch = 'jam'
  elseif l:buch == 'jes'   | let l:buch = 'isa'
  elseif l:buch == 'sach'  | let l:buch = 'zec'
  elseif l:buch == 'mt'    | let l:buch = 'mat'
  elseif l:buch == 'mk'    | let l:buch = 'mar'
  elseif l:buch == 'lk'    | let l:buch = 'luk'
  elseif l:buch == 'joh'   | let l:buch = 'jhn'
  elseif l:buch == 'hebr'  | let l:buch = 'heb'
  elseif l:buch == 'offb'  | let l:buch = 'rev'
  endif

" call OpenUrl#Go("http://www.blueletterbible.org/Bible.cfm?b=" . l:buch . "&c=" . a:vers['kapitel'] . "&v=" . a:vers['vers'] . "&t=KJV#" . a:vers['vers'])
  call OpenUrl#Go("http://www.blueletterbible.org/kjv/" . l:buch . '/'. a:vers['kapitel'] . '/' . a:vers['vers'])

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#BlueLetterWithInput() " {
  call TQ84_log_indent(expand("<sfile>"))
  let l:vers = Bibel#EingabeBuchKapitelVers()

  if keys(l:vers) == []
    call TQ84_log('Kein Vers eingegeben')
    call TQ84_log_dedent()
    return ''
  endif

  call OpenUrl#BlueLetter(l:vers)

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#Kommentar(vers) " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:buch = a:vers['buch']

  let l:seperate_chapters = 1

  if l:seperate_chapters " {

    let l:buch_ = l:buch . '_' . a:vers['kapitel'] . '.html'

  " }
  else " {

  if l:buch == 'ri' || l:buch == 'rt'
    let l:buch_ = 'ri_rt.html'
  elseif l:buch == 'esr' || l:buch == 'neh' || l:buch == 'est'
    let l:buch_ = 'esr_neh_est.html'
  elseif l:buch == 'pred' || l:buch == 'hl'
    let l:buch_ = 'pred_hl.html'
  elseif l:buch == 'hos' || l:buch == 'joe' || l:buch == 'am' || l:buch == 'ob' || l:buch == 'jon' || l:buch == 'mi'
    let l:buch_ ='hos_joe_am_ob_jon_mi.html'
  elseif l:buch == 'nah' || l:buch == 'hab' || l:buch == 'zeph' || l:buch == 'hag' || l:buch == 'sach' || l:buch == 'mal'
    let l:buch_ ='nah_hab_zeph_hag_sach_mal.html'
  elseif l:buch == '1kor' || l:buch == '2kor'
    let l:buch_ ='kor.html'
  elseif l:buch == 'gal' || l:buch == 'eph' || l:buch == 'phil' || l:buch == 'kol' || l:buch == '1thes' || l:buch == '2thes'
    let l:buch_ ='gal_eph_phil_kol_thes.html'
  elseif l:buch == '1tim' || l:buch == '2tim' || l:buch == 'tit' || l:buch == 'phim' || l:buch == 'hebr'
    let l:buch_ ='tim_tit_phim_hebr.html'
  elseif l:buch == 'jak' || l:buch == '1petr' || l:buch == '2petr' || l:buch == '1joh' || l:buch == '2joh' || l:buch == '3joh' || l:buch == 'jud'
    let l:buch_ ='jak_petr_joh_jud.html'
  else
    let l:buch_ = l:buch . '.html'
  endif

  endif " }

  call TQ84_log("l:buch = " . l:buch . " / l:buch_ = " . l:buch_)

  let l:url = 'file://' . $rn_root . 'local/Biblisches/Kommentare/'. l:buch_ . '#I' . a:vers['buch'] . '-' . a:vers['kapitel'] . '-' . a:vers['vers']

  call TQ84_log('l:url = ' . l:url)
  call OpenUrl#Go(l:url)

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#KommentarMitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  let l:vers = Bibel#EingabeBuchKapitelVers()
  if keys(l:vers) == []
    call TQ84_log('Kein Vers eingegeben')
    call TQ84_log_dedent()
    return ''
  endif

  call OpenUrl#Kommentar(l:vers)

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#StrongsWithInput() " {
  call TQ84_log_indent(expand("<sfile>"))
  let l:strongs_nr = input("Strongs Number, prefix with G or H: ")

  call OpenUrl#Go("http://www.blueletterbible.org/lang/lexicon/lexicon.cfm?Strongs=" . l:strongs_nr)
  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#BibelOnlineMitEingabe(uebersetzung) " {
  call TQ84_log_indent(expand("<sfile>") . ' ' . a:uebersetzung)

  let l:vers = Bibel#EingabeBuchKapitelVers()
  if keys(l:vers) == []
    call TQ84_log('Kein Vers eingegeben')
    call TQ84_log_dedent()
    return
  endif
  call OpenUrl#BibelOnline(a:uebersetzung, l:vers)

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#BibelOnline(uebersetzung, vers) " {

  call TQ84_log_indent(expand("<sfile>") . ' Uebersetzung: ' . a:uebersetzung . ', Buch: ' . a:vers['buch'] . ', Kapitel: ' . a:vers['kapitel'])

  let l:buch = tolower(Bibel#BuchnameAusAbkuerzung(a:vers['buch']))

  let l:buch = substitute(l:buch, '\v(\d)\. ', '\1_', '')
  let l:buch = substitute(l:buch, 'ä'        , 'ae' , '')
  let l:buch = substitute(l:buch, 'ö'        , 'oe' , '')
  let l:buch = substitute(l:buch, 'thessaloniker', 'thessalonicher', '')

  call TQ84_log('l:buch = ' . l:buch)

  call OpenUrl#Go("http://www.bibel-online.net/buch/" . a:uebersetzung . '/' . l:buch . '/' . a:vers['kapitel'] . '/#' . a:vers['vers'])
  call TQ84_log_dedent()

endfu " }

fu! OpenUrl#MengeUebersetzungMitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  let l:vers = Bibel#EingabeBuchKapitelVers()
  if keys(l:vers) == [] " {
    call TQ84_log('Kein Vers eingegeben')
    call TQ84_log_dedent()
    return
  endif " }

  call TQ84_log('buch ' . l:vers['buch'] . ', kapitel: ' . l:vers['kapitel'])

  if     l:vers['buch'] == '1mo'    | let l:buch_nr = '01' " {
  elseif l:vers['buch'] == '2mo'    | let l:buch_nr = '02'
  elseif l:vers['buch'] == '3mo'    | let l:buch_nr = '03'
  elseif l:vers['buch'] == '4mo'    | let l:buch_nr = '04'
  elseif l:vers['buch'] == '5mo'    | let l:buch_nr = '05'
  elseif l:vers['buch'] == 'jos'    | let l:buch_nr = '06'
  elseif l:vers['buch'] == 'ri'     | let l:buch_nr = '07'
  elseif l:vers['buch'] == 'rt'     | let l:buch_nr = '08'
  elseif l:vers['buch'] == '1sam'   | let l:buch_nr = '09'
  elseif l:vers['buch'] == '2sam'   | let l:buch_nr = '10'
  elseif l:vers['buch'] == '1koe'   | let l:buch_nr = '11'
  elseif l:vers['buch'] == '2koe'   | let l:buch_nr = '12'
  elseif l:vers['buch'] == '1chr'   | let l:buch_nr = '13'
  elseif l:vers['buch'] == '2chr'   | let l:buch_nr = '14'
  elseif l:vers['buch'] == 'esr'    | let l:buch_nr = '15'
  elseif l:vers['buch'] == 'neh'    | let l:buch_nr = '16'
  elseif l:vers['buch'] == 'est'    | let l:buch_nr = '17'
  elseif l:vers['buch'] == 'hi'     | let l:buch_nr = '18'
  elseif l:vers['buch'] == 'ps'     | let l:buch_nr = '19'
  elseif l:vers['buch'] == 'spr'    | let l:buch_nr = '20'
  elseif l:vers['buch'] == 'pred'   | let l:buch_nr = '21'
  elseif l:vers['buch'] == 'hl'     | let l:buch_nr = '22'
  elseif l:vers['buch'] == 'jes'    | let l:buch_nr = '23'
  elseif l:vers['buch'] == 'jer'    | let l:buch_nr = '24'
  elseif l:vers['buch'] == 'kla'    | let l:buch_nr = '25'
  elseif l:vers['buch'] == 'hes'    | let l:buch_nr = '26'
  elseif l:vers['buch'] == 'dan'    | let l:buch_nr = '27'
  elseif l:vers['buch'] == 'hos'    | let l:buch_nr = '28'
  elseif l:vers['buch'] == 'joe'    | let l:buch_nr = '29'
  elseif l:vers['buch'] == 'am'     | let l:buch_nr = '30'
  elseif l:vers['buch'] == 'ob'     | let l:buch_nr = '31'
  elseif l:vers['buch'] == 'jon'    | let l:buch_nr = '32'
  elseif l:vers['buch'] == 'mi'     | let l:buch_nr = '33'
  elseif l:vers['buch'] == 'nah'    | let l:buch_nr = '34'
  elseif l:vers['buch'] == 'hab'    | let l:buch_nr = '35'
  elseif l:vers['buch'] == 'zeph'   | let l:buch_nr = '36'
  elseif l:vers['buch'] == 'hag'    | let l:buch_nr = '37'
  elseif l:vers['buch'] == 'sach'   | let l:buch_nr = '38'
  elseif l:vers['buch'] == 'mal'    | let l:buch_nr = '39'
  elseif l:vers['buch'] == 'mt'     | let l:buch_nr = '50'
  elseif l:vers['buch'] == 'mk'     | let l:buch_nr = '51'
  elseif l:vers['buch'] == 'lk'     | let l:buch_nr = '52'
  elseif l:vers['buch'] == 'joh'    | let l:buch_nr = '53'
  elseif l:vers['buch'] == 'apg'    | let l:buch_nr = '54'
  elseif l:vers['buch'] == 'roem'   | let l:buch_nr = '55'
  elseif l:vers['buch'] == '1kor'   | let l:buch_nr = '56'
  elseif l:vers['buch'] == '2kor'   | let l:buch_nr = '57'
  elseif l:vers['buch'] == 'gal'    | let l:buch_nr = '58'
  elseif l:vers['buch'] == 'eph'    | let l:buch_nr = '59'
  elseif l:vers['buch'] == 'phil'   | let l:buch_nr = '60'
  elseif l:vers['buch'] == 'kol'    | let l:buch_nr = '61'
  elseif l:vers['buch'] == '1thes'  | let l:buch_nr = '62'
  elseif l:vers['buch'] == '2thes'  | let l:buch_nr = '63'
  elseif l:vers['buch'] == '1tim'   | let l:buch_nr = '64'
  elseif l:vers['buch'] == '2tim'   | let l:buch_nr = '65'
  elseif l:vers['buch'] == 'tit'    | let l:buch_nr = '66'
  elseif l:vers['buch'] == 'phim'   | let l:buch_nr = '67'
  elseif l:vers['buch'] == 'hebr'   | let l:buch_nr = '68'
  elseif l:vers['buch'] == 'jak'    | let l:buch_nr = '69'
  elseif l:vers['buch'] == '1petr'  | let l:buch_nr = '70'
  elseif l:vers['buch'] == '2petr'  | let l:buch_nr = '71'
  elseif l:vers['buch'] == '1joh'   | let l:buch_nr = '72'
  elseif l:vers['buch'] == '2joh'   | let l:buch_nr = '73'
  elseif l:vers['buch'] == '3joh'   | let l:buch_nr = '74'
  elseif l:vers['buch'] == 'jud'    | let l:buch_nr = '75'
  elseif l:vers['buch'] == 'offb'   | let l:buch_nr = '76'
  endif " }

  call TQ84_log('buch_nr ' . l:buch_nr)

  call OpenUrl#Go("https://www.die-bibel.de/online-bibeln/menge-bibel/bibeltext/bibel/text/lesen/stelle/" . l:buch_nr . '/' . l:vers['kapitel'] . '0001/' . l:vers['kapitel'] . '9999/')

  call TQ84_log_dedent()

endfu " }

fu! OpenUrl#NeueEVUebMitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  let l:vers = Bibel#EingabeBuchKapitelVers()
  if keys(l:vers) == [] " {
    call TQ84_log('Kein Vers eingegeben')
    call TQ84_log_dedent()
    return
  endif " }

  let l:buch = l:vers['buch']

  if     l:buch ==# 'rt' " {
     let l:buch = 'rut'
  elseif l:buch ==# 'esr'
     let l:buch = 'esra'
  elseif l:buch ==# 'hi'
     let l:buch = 'hiob'
  elseif l:buch ==# 'joe'
     let l:buch = 'joel'
  elseif l:buch ==# 'am'
     let l:buch = 'amos'
  elseif l:buch ==# 'ob'
     let l:buch = 'obadja'
  elseif l:buch ==# 'jon'
     let l:buch = 'jona'
  elseif l:buch ==# 'zeph'
     let l:buch = 'zef'
  elseif l:buch ==# 'joh'
     let l:buch = 'jo'
  elseif l:buch ==# 'roem'
     let l:buch = 'roe'
  elseif l:buch ==# 'phim'
     let l:buch = 'phm'
  elseif l:buch ==# '1petr'
     let l:buch = '1pt'
  elseif l:buch ==# '2petr'
     let l:buch = '2pt'
  elseif l:buch ==# '1joh'
     let l:buch = '1jo'
  elseif l:buch ==# '2joh'
     let l:buch = '2jo'
  elseif l:buch ==# '3joh'
     let l:buch = '3jo'
  elseif l:buch ==# 'offb'
     let l:buch = 'off'
  endif " }

  call TQ84_log('l:buch = ' . l:buch)

" 2017-01-13
" call OpenUrl#Go('http://www.alt.kh-vanheiden.de/NeUe/Bibeltexte/' . l:buch . '.html#' . l:vers['kapitel'])
  call OpenUrl#Go('https://neue.derbibelvertrauen.de/' . l:buch . '.html#' . l:vers['kapitel'])

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#NT_W_Einert_MitEingabe() " { Neues Testament von w. Einert
  call TQ84_log_indent(expand("<sfile>"))

  let l:vers = Bibel#EingabeBuchKapitelVers()
  if keys(l:vers) == [] " {
    call TQ84_log('Kein Vers eingegeben')
    call TQ84_log_dedent()
    return
  endif " }

  let l:buch = l:vers['buch']
  let l:kap  = l:vers['kapitel']

  if     l:buch ==# 'mt' " {
     let l:buch = 'M'
  elseif l:buch ==# 'mk'
     let l:buch = 'MK'
  elseif l:buch ==# 'lk'
     let l:buch = 'L'
  elseif l:buch ==# 'joh'
     let l:buch = 'J'
  elseif l:buch ==# 'apg'
     let l:buch = 'A'
  elseif l:buch ==# 'roem'
     let l:buch = 'R'
  elseif l:buch ==# '1kor'
     let l:buch = '1K'
  elseif l:buch ==# '2kor'
     let l:buch = '2K'
  elseif l:buch ==# 'gal'
     let l:buch = 'G'
  elseif l:buch ==# 'eph'
     let l:buch = 'E'
  elseif l:buch ==# 'phil'
     let l:buch = 'P'
  elseif l:buch ==# 'kol'
     let l:buch = 'K'
  elseif l:buch ==# '1thes'
     let l:buch = '1TH'
  elseif l:buch ==# '2thes'
     let l:buch = '2TH'
  elseif l:buch ==# '1tim'
     let l:buch = '1TM'
  elseif l:buch ==# '2tim'
     let l:buch = '2TM'
  elseif l:buch ==# 'tit'
     let l:buch = 'T'
  elseif l:buch ==# 'phim'
     let l:buch = 'PM'
     let l:kapitel = ''
  elseif l:buch ==# 'joh'
     let l:buch = 'J'
  elseif l:buch ==# 'hebr'
     let l:buch = 'H'
  elseif l:buch ==# 'jak'
     let l:buch = 'JK'
  elseif l:buch ==# '1petr'
     let l:buch = '1P'
  elseif l:buch ==# '2petr'
     let l:buch = '2P'
  elseif l:buch ==# '1joh'
     let l:buch = '1J'
  elseif l:buch ==# '1joh'
     let l:buch = '1J'
  elseif l:buch ==# '2joh'
     let l:buch = '2J'
  elseif l:buch ==# '3joh'
     let l:buch = '3J'
  elseif l:buch ==# 'jud'
     let l:buch = 'JD'
  elseif l:buch ==# 'offb'
     let l:buch = 'EH'
  endif " }

  call TQ84_log('l:buch = ' . l:buch)

  let l:url = 'http://www.bibelthemen.eu/we_nt/' . l:buch . l:kap . '.htm'
  call TQ84_log('url = ' . l:url)

  call OpenUrl#Go(l:url)

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#dict_leo_org(searchTerm) " {
  call TQ84_log_indent(expand("<sfile>"))

  call TQ84_log('l:searchTerm = ' . a:searchTerm)

  let l:url = 'http://dict.leo.org/ende/index_de.html#/search=' . a:searchTerm
  call TQ84_log('url = ' . l:url)

  call OpenUrl#Go(l:url)

  call TQ84_log_dedent()
endfu " }


call TQ84_log_dedent()
