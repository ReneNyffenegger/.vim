call TQ84_log_indent(expand("<sfile>"))

fu! Input#BuchKapitelVers() " {

  call TQ84_log_indent(expand("<sfile>"))

  call TQ84_log('deprecated, use Bibel#EingabeBuchKapitelVers')

  let l:ret = Bibel#EingabeBuchKapitelVers()

  call TQ84_log_dedent()

  return l:ret

endfu " }

call TQ84_log_dedent()
