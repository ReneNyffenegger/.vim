call TQ84_log_indent(expand('<sfile>'))

fu! tq84#ft#bibel#currentVerse() " {
  call TQ84_log_indent('tq84#ft#bibel#currentVerse')

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

  call TQ84_log_dedent()
endfu " }


call TQ84_log_dedent()
