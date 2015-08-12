" 
"  TODO:  https://github.com/ReneNyffenegger/open-browser.vim/blob/master/plugin/openbrowser.vim
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

fu! OpenUrl#BlueLetterWithInput() " {
  call TQ84_log_indent(expand("<sfile>"))
  let l:buch_kapitel_vers = input("Buch Kapitel Vers: ")
  
  let l:buch_kapitel_vers_ = matchlist(l:buch_kapitel_vers, '\(\w\+\) \(\w\+\) \(\w\+\)')
  
  let l:buch    = buch_kapitel_vers_[1]
  let l:kapitel = buch_kapitel_vers_[2]
  let l:vers    = buch_kapitel_vers_[3]
  
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
  
  call OpenUrl#Go("http://www.blueletterbible.org/Bible.cfm?b=" . l:buch . "&c=" . l:kapitel . "&v=" . l:vers . "&t=KJV#" . l:vers)
  call TQ84_log_dedent()
endfu " }

fu! OpenUrl#KommentarMitEingabe() " {
  call TQ84_log_indent(expand("<sfile>") . "-BlueLetterWithInput")

  let l:buch_kapitel_vers = input("Buch Kapitel Vers: ")
  
  let l:buch_kapitel_vers_ = matchlist(l:buch_kapitel_vers, '\(\w\+\) \(\w\+\) \(\w\+\)')
  
  let l:buch    = buch_kapitel_vers_[1]
  let l:kapitel = buch_kapitel_vers_[2]
  let l:vers    = buch_kapitel_vers_[3]

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

" let l:dummy = RN_OpenBlueLetter(l:book, l:bk_ch_v_[2], l:bk_ch_v_[3])
  call TQ84_log("l:buch = " . l:buch . " / l:buch_ = " . l:buch_)
  call OpenUrl#Go("file://c:\\schlachter2000\\" . l:buch_ . '#I' . l:buch . '-' . l:kapitel . '-' . l:vers)

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
  
  call OpenUrl#BibelOnline('luther_1545_letzte_hand', Input#BuchKapitelVers())
  
  call TQ84_log_dedent()

endfu " }

fu! OpenUrl#BibelOnline(uebersetzung, vers) " {
  call TQ84_log_indent(expand("<sfile>"))

  if a:vers['buch'] == 'hebr'
     let l:buch = 'hebraeer'
  endif

  call OpenUrl#Go("http://www.bibel-online.net/buch/" . a:uebersetzung . '/' . l:buch . '/' . a:vers['kapitel'] . '/#' . a:vers['vers'])
  call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
