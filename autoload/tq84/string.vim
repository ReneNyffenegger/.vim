call TQ84_log_indent(expand('<sfile>'))

fu! tq84#string#fromEnd(str, len) " {

    let l:ret = strpart(a:str, len(a:str) - a:len)
    call TQ84_log('tq84#string#fromEnd: ' . a:str . ', ' . a:len . ' -> ' . l:ret)
    return l:ret

endfu " }

call TQ84_log_dedent()
