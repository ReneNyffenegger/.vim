call TQ84_log_indent(expand("<sfile>"))

fu! Input#BuchKapitelVers() " {

  call TQ84_log_indent(expand("<sfile>"))

  let l:buch_kapitel_vers = input("Buch Kapitel Vers: ")
  
  let l:buch_kapitel_vers_ = matchlist(l:buch_kapitel_vers, '\(\w\+\) \(\w\+\) \(\w\+\)')

  let l:ret = {
     \ 'buch'   : buch_kapitel_vers_[1],
     \ 'kapitel': buch_kapitel_vers_[2],
     \ 'vers'   : buch_kapitel_vers_[3]}

  call TQ84_log_dedent()

  return l:ret

endfu " }

call TQ84_log_dedent()
