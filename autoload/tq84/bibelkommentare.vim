call TQ84_log_indent(expand('<sfile>'))

fu! tq84#bibelkommentare#searchVerse(bkv) " {
  call TQ84_log_indent('bibelkommentare#searchVerse')

  let l:pattern_ch = '^#' . a:bkv['buch'] . '-' . a:bkv['kapitel']

  let l:pattern =  l:pattern_ch . '-' . a:bkv['vers'] . ' {'
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

       let l:pattern = l:pattern_ch . '-' . l:vers . ' {'
       let l:lineNo = search(l:pattern)
       let l:vers = l:vers - 1

     endwhile

     call search('#}') " go to end of verse

     call append(line('.'), ['#' . a:bkv['buch'] . '-' . a:bkv['kapitel'] . '-' . a:bkv['vers'] . ' {', '#}'])
     execute 'normal ' . (line('.') + 1) . 'G'

  endif " }
  
  normal zM
  normal zv

  call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
