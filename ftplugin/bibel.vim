call TQ84_log_indent(expand('<sfile>'))

so $github_root/Biblisches/vim/Kommentare-Perl.vim

fu! <SID>VersIDDerAktuellenZeile() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:line = getline('.')

  let l:teile = matchlist(l:line, '\v^([^-]+)-([^-]+)-([^|]+)')

  let l:ret = {
  \     'buch'   : l:teile[1],
  \     'kapitel': l:teile[2],
  \     'vers'   : l:teile[3]
  \ }

  call TQ84_log('ret = ' . string(l:ret))

  call TQ84_log_dedent()

  return l:ret
endfu " }

fu! <SID>VersTextDerAktuellenZeile() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:line = getline('.')

  call TQ84_log('l:line = ' . l:line)

  let l:yanked = substitute(l:line, '\v.*\|(.*)\|.*', '\1', '')

  call TQ84_log('l:yanked = ' . l:yanked)

  call TQ84_log_dedent()

  return l:yanked
endfu " }

fu! <SID>GeheZuKommentar() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:vers = <SID>VersIDDerAktuellenZeile()

  call OpenUrl#Kommentar(l:vers)

  call TQ84_log_dedent()
endfu " }

fu! <SID>GeheZuAlleKommentare() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:vers = <SID>VersIDDerAktuellenZeile()

  call Kommentare_GeheZuVers(l:vers)

  call TQ84_log_dedent()
endfu " }

fu! <SID>OpenBlueLetter() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:vers = <SID>VersIDDerAktuellenZeile()

  call OpenUrl#BlueLetter(l:vers)

  call TQ84_log_dedent()
endfu " }

fu! <SID>CopyElberfelder() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:line = getline('.')
  if l:line =~# '\v\|.*\|\s*#'
     call TQ84_log('Zeile hat bereits einen Kommentar')
     call TQ84_log_dedent()
     return
  endif

  let l:vers = <SID>VersIDDerAktuellenZeile()
  let l:text_elberfelder = Bibel#VersText(l:vers, 'elb1905')

  execute "normal 0f|lct|" . l:text_elberfelder
  normal A # M ~elb

  call TQ84_log_dedent()
endfu " }


nnoremap <buffer> <leader>yv :let @*=<SID>VersTextDerAktuellenZeile()<CR>
nnoremap <buffer> ,gtk       :call <SID>GeheZuKommentar()<CR>
nnoremap <buffer> ,gta       :call <SID>GeheZuAlleKommentare()<CR>
nnoremap <buffer> ,bl        :call <SID>OpenBlueLetter()<CR>
nnoremap <buffer> ,v<bar>     0f<bar>lvf<bar>h
nnoremap <buffer> ,celb      :call <SID>CopyElberfelder()<CR>

nnoremap <buffer> / /\ze.*<bar><left><left><left><left><left><left>
nnoremap <buffer> k/ /#.*

call TQ84_log_dedent()
