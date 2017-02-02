call TQ84_log_indent(expand('<sfile>'))

fu tq84#buf#method#currentVerse() " {
  call TQ84_log_indent('tq84#buf#method#currentVerse')

  if exists('b:tq84_methods')

     if has_key(b:tq84_methods, 'currentVerse')
        let l:ret = b:tq84_methods.currentVerse()
     else
       call TQ84_log('b:tq84_methods does not have key currentVerse')
       let l:ret = Bibel#EingabeBuchKapitelVers()
     endif

  else
     call TQ84_log('b:tq84_methods does not exist')
       let l:ret = Bibel#EingabeBuchKapitelVers()
  endif

  call TQ84_log('returning ' . string(l:ret))
  call TQ84_log_dedent()
  return l:ret
endfu " }


call TQ84_log_dedent()
