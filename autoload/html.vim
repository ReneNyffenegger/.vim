call TQ84_log_indent(expand('<sfile>'))

" { s:entities
let s:entities = [
\   ['auml'  , 'ä' ],
\   ['ouml'  , 'ö' ],
\   ['uuml'  , 'ü' ],
\   ['Auml'  , 'Ä' ],
\   ['Ouml'  , 'Ö' ],
\   ['Uuml'  , 'Ü' ],
\   ['szlig' , 'ß' ], 
\   ['eacute', 'é' ], 
\   ['nbsp'  , ' ' ], 
\   ['raquo' , "'" ], 
\   ['laquo' , "'" ], 
\   ['ndash' , '-' ],
\ ]
" }

fu! html#decode(html) " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:text = a:html

  for l:e in s:entities
    let l:text = substitute(l:text, '\C&' . l:e[0] . ';', l:e[1], 'g')
  endfor

  let l:text = substitute(l:text, '\C&amp;', '\&', 'g')

  call TQ84_log_dedent()
  return l:text
endfu " }
fu! html#encode(text) " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:html = a:text
  for l:e in s:entities
    let l:html = substitute(l:html, '\C' . l:e[1], '\&' . l:e[0] . ';', 'g')
  endfor

  let l:html = substitute(l:html, '&', '\&amp;', 'g')

  call TQ84_log_dedent()
  return l:html
endfu " }
fu! html#decodeInFile(nbsp) " {
  "
  "  The parameter nbsp determines, if &nbsp; should be
  "  translated into spaces (' ') or left as they are.
  "
  call TQ84_log_indent(expand('<sfile>'))

  for l:e in s:entities
    if l:e[0] == 'nbsp' && a:nbsp
       next
    endif
    call ReplaceInFile('\&' . '\C&' . l:e[0] . ';', l:e[1])
  endfor

  call TQ84_log_dedent()
endfu!

call TQ84_log_dedent()
