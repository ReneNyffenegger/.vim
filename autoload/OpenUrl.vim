"
"  TODO:
"  https://github.com/tyru/open-browser.vim/blob/master/plugin/openbrowser.vim
"

call TQ84_log_indent(expand("<sfile>"))

fu! OpenUrl#Go(url) " {

  call TQ84_log_indent(expand("<sfile>") . "-OpenUrl#Go: " . a:url)
  let use_mozilla = 1

  let l:url = substitute(a:url, '#', '\\#', 'g')
  let l:url = substitute(l:url, '&', '^&' , 'g')


  call TQ84_log("url = " . l:url)

  if use_mozilla == 1
"   let d = system("\"c:\\Program Files\\Mozilla Firefox\\firefox.exe\" -url " . a:url )
    execute "silent !start cmd /c start firefox -url " . l:url
  else
"   let d = system("start chrome.exe " . a:url)
    execute "silent !start cmd /c start chrome  " . l:url
  endif

  call TQ84_log_dedent()

endfu " }

fu! OpenUrl#BlueLetter(vers) " {
  call TQ84_log_indent(expand("<sfile>"))


  let l:buch    = a:vers['buch']
" let l:kapitel = buch_kapitel_vers_[2]
" let l:vers    = buch_kapitel_vers_[3]

  if     l:buch == '1mo'   | let l:buch = 'gen'
  elseif l:buch == '2mo'   | let l:buch = 'ex'
  elseif l:buch == '3mo'   | let l:buch = 'lev'
  elseif l:buch == '4mo'   | let l:buch = 'num'
  elseif l:buch == '5mo'   | let l:buch = 'deu'
  elseif l:buch == '1koe'  | let l:buch = '1king'
  elseif l:buch == '2koe'  | let l:buch = '2king'
  elseif l:buch == 'esr'   | let l:buch = 'ezr'
  elseif l:buch == 'hi'    | let l:buch = 'job'
  elseif l:buch == 'pred'  | let l:buch = 'eccl'
  elseif l:buch == 'kla'   | let l:buch = 'lam'
  elseif l:buch == 'hes'   | let l:buch = 'eze'
  elseif l:buch == 'spr'   | let l:buch = 'pro'
  elseif l:buch == 'roem'  | let l:buch = 'rom'
  elseif l:buch == 'apg'   | let l:buch = 'acts'
  elseif l:buch == '1kor'  | let l:buch = '1cor'
  elseif l:buch == '2kor'  | let l:buch = '2cor'
  elseif l:buch == '1petr' | let l:buch = '1pe'
  elseif l:buch == '2petr' | let l:buch = '2pe'
  elseif l:buch == 'kol'   | let l:buch = 'col'
  elseif l:buch == 'phim'  | let l:buch = 'phm'
  elseif l:buch == 'jak'   | let l:buch = 'jam'
  elseif l:buch == 'jes'   | let l:buch = 'isa'
  elseif l:buch == 'sach'  | let l:buch = 'zec'
  elseif l:buch == 'offb'  | let l:buch = 'rev'
  elseif l:buch == 'ri'    | let l:buch = 'judg'
  elseif l:buch == 'rt'    | let l:buch = 'ru'
  elseif l:buch == 'hl'    | let l:buch = 'song'
  endif

  call OpenUrl#Go("http://www.blueletterbible.org/Bible.cfm?b=" . l:buch . "&c=" . a:vers['kapitel'] . "&v=" . a:vers['vers'] . "&t=KJV#" . a:vers['vers'])
  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#BlueLetterWithInput() " {
  call TQ84_log_indent(expand("<sfile>"))
  let l:vers = Bibel#EingabeBuchKapitelVers()

" let l:buch_kapitel_vers_ = matchlist(l:buch_kapitel_vers, '\(\w\+\) \(\w\+\) \(\w\+\)')

  call OpenUrl#BlueLetter(l:vers)

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#Kommentar(vers) " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:buch = a:vers['buch']

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

  call TQ84_log("l:buch = " . l:buch . " / l:buch_ = " . l:buch_)
  let l:url = 'file://c:\schlachter2000\' . l:buch_ . '#I' . a:vers['buch'] . '-' . a:vers['kapitel'] . '-' . a:vers['vers']
  call TQ84_log('l:url = ' . l:url)
  call OpenUrl#Go(l:url)

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#KommentarMitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  let l:vers = Bibel#EingabeBuchKapitelVers()

  call OpenUrl#Kommentar(l:vers)

  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#StrongsWithInput() " {
  call TQ84_log_indent(expand("<sfile>"))
  let l:strongs_nr = input("Strongs Number, prefix with G or H: ")

  call OpenUrl#Go("http://www.blueletterbible.org/lang/lexicon/lexicon.cfm?Strongs=" . l:strongs_nr . "&t=KJV")
  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#BibelOnlineLuther1545MitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  call OpenUrl#BibelOnline('luther_1545_letzte_hand', Bibel#EingabeBuchKapitelVers())

  call TQ84_log_dedent()

endfu " }
fu! OpenUrl#BibelOnlineLuther1912MitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  call OpenUrl#BibelOnline('luther_1912', Bibel#EingabeBuchKapitelVers())

  call TQ84_log_dedent()

endfu " }
fu! OpenUrl#BibelOnlineInterlinearMitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  call OpenUrl#BibelOnline('interlinear', Bibel#EingabeBuchKapitelVers())

  call TQ84_log_dedent()

endfu " }
fu! OpenUrl#BibelOnlineNeueEvangelistischeMitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  call OpenUrl#BibelOnline('neue_evangelistische', Bibel#EingabeBuchKapitelVers())

  call TQ84_log_dedent()

endfu " }
fu! OpenUrl#BibelOnlineSchlachter51MitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  call OpenUrl#BibelOnline('schlachter_1951', Bibel#EingabeBuchKapitelVers())

  call TQ84_log_dedent()

endfu " }
fu! OpenUrl#BibelOnlineElberfelder1905MitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  call OpenUrl#BibelOnline('elberfelder_1905', Bibel#EingabeBuchKapitelVers())

  call TQ84_log_dedent()

endfu " }

fu! OpenUrl#BibelOnline(uebersetzung, vers) " {

  call TQ84_log_indent(expand("<sfile>") . ' Buch: ' . a:vers['buch'] . ', Kapitel: ' . a:vers['kapitel'])

  let l:buch = tolower(Bibel#BuchnameAusAbkuerzung(a:vers['buch']))

  let l:buch = substitute(l:buch, '\v(\d)\. ', '\1_', '')
  let l:buch = substitute(l:buch, 'ä'        , 'ae' , '')
  let l:buch = substitute(l:buch, 'ö'        , 'oe' , '')

  call TQ84_log('l:buch = ' . l:buch)

  call OpenUrl#Go("http://www.bibel-online.net/buch/" . a:uebersetzung . '/' . l:buch . '/' . a:vers['kapitel'] . '/#' . a:vers['vers'])
  call TQ84_log_dedent()

endfu " }

fu! OpenUrl#MengeUebersetzungMitEingabe() " {
  call TQ84_log_indent(expand("<sfile>"))

  let l:vers = Bibel#EingabeBuchKapitelVers()

  call TQ84_log('buch ' . l:vers['buch'] . ', kapitel: ' . l:vers['kapitel'])

  if     l:vers['buch'] == '1mo'    | let l:buch_nr = '01'
  elseif l:vers['buch'] == '2mo'    | let l:buch_nr = '02'
  elseif l:vers['buch'] == '3mo'    | let l:buch_nr = '03'
  elseif l:vers['buch'] == '4mo'    | let l:buch_nr = '04'
  elseif l:vers['buch'] == '5mo'    | let l:buch_nr = '05'
  elseif l:vers['buch'] == 'jos'    | let l:buch_nr = '06'
  elseif l:vers['buch'] == 'hi'     | let l:buch_nr = '18'
  elseif l:vers['buch'] == 'ps'     | let l:buch_nr = '19'
  elseif l:vers['buch'] == '1kor'   | let l:buch_nr = '56'
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
  endif

  call TQ84_log('buch_nr ' . l:buch_nr)

  call OpenUrl#Go("https://www.die-bibel.de/online-bibeln/menge-bibel/bibeltext/bibel/text/lesen/stelle/" . l:buch_nr . '/' . l:vers['kapitel'] . '0001/' . l:vers['kapitel'] . '9999/')

  call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
