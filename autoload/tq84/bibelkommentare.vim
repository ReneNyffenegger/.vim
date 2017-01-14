call TQ84_log_indent(expand('<sfile>'))

fu! tq84#bibelkommentare#searchVerse(bkv) " {
  call TQ84_log_indent('bibelkommentare#searchVerse')

  let l:pattern_ch = '^#' . a:bkv['buch'] . '-' . a:bkv['kapitel']

  let l:pattern =  l:pattern_ch . '-' . a:bkv['vers'] . ' ' . nr2char(123)
  call TQ84_log('searching for ' . l:pattern)
  let l:lineNo = search(l:pattern, 'w')

  call TQ84_log('l:lineNo = ' . l:lineNo)

  if l:lineNo == 0 " {

     call TQ84_log('Does chapter exist, searching for ' . l:pattern_ch)
     let l:lineNo_ch = search(l:pattern_ch, 'w')

     if l:lineNo_ch == 0 " {
        call TQ84_log('Chapter does not exist')
        call TQ84_log_dedent()
        return
     endif " }

     let l:vers = a:bkv['vers'] - 1
    
     while l:lineNo == 0 && l:vers > 0

       let l:pattern = l:pattern_ch . '-' . l:vers . ' ' . nr2char(125)
       let l:lineNo = search(l:pattern)
       let l:vers = l:vers - 1

     endwhile

     call search('#}') " go to end of verse

     call append(line('.'), ['#' . a:bkv['buch'] . '-' . a:bkv['kapitel'] . '-' . a:bkv['vers'] . ' ' . nr2char(123), '#}'])
     execute 'normal ' . (line('.') + 1) . 'G'

  endif " }
 
  normal zM
  normal zv

  call TQ84_log_dedent()
endfu " }

fu! tq84#bibelkommentare#substitute_a_href() range " {
  call TQ84_log_indent('tq84#substitute_a_href')

  for i in range(a:firstline, a:lastline) " {

    let l:line = getline(i)

    let l:line = substitute(l:line, "\\v\\<a href\\='http://bibel.renenyffenegger.ch/([^_]+)_(\\d+).html#v(\\d+)'\\>[^<]+\\d+,\\d+\\</a\\>", '§\1-\2-\3', "g")
    let l:line = substitute(l:line, "\\v\\<a class\\='kom' href\\='#I([^-]+)-(\\d+)-(\\d+)'\\>[^<]+\\d+,\\d+\\</a\\>", '§+\1-\2-\3', "g")
   
    let l:line = substitute(l:line, "\\v\\<a href\\='http://bibel.renenyffenegger.ch/([^_]+)_(\\d+).html#v(\\d+)'\\>[^<]+\\d+,\\d+-(\\d+)\\</a\\>", '§\1-\2-\3-\4', "g")
    let l:line = substitute(l:line, "\\v\\<a class\\='kom' href\\='#I([^-]+)-(\\d+)-(\\d+)'\\>[^<]+\\d+,\\d+-(\\d+)\\</a\\>", '§+\1-\2-\3-\4', "g")

    call setline(i, l:line)
  endfor " }

  call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
