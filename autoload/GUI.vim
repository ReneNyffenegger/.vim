call TQ84_log_indent(expand('<sfile>') . ': ' . expand('<slnum>'))

fu! GUI#Minimize() " {
    call TQ84_log_indent(expand('<sfile>') . ': ' . expand('<slnum>'))
    simalt ~n
    call TQ84_log_dedent()
endfu " }

fu! GUI#Maximize() " {
    call TQ84_log_indent(expand('<sfile>') . ': ' . expand('<slnum>'))
    simalt ~x
    call TQ84_log_dedent()
endfu " }

fu! GUI#NormalSize() " {
    call TQ84_log_indent(expand('<sfile>') . ': ' . expand('<slnum>'))
    simalt ~w
    call TQ84_log_dedent()
endfu " }

fu! GUI#ChangeMonitor(x, y) " {
    call TQ84_log_indent(expand('<sfile>') . ': ' . expand('<slnum>'))

    call GUI#NormalSize()
    sleep 10m

    let l:winpos_cmd = 'winpos ' . a:x . ' ' . a:y
    call TQ84_log('winpos_cmd: ' . l:winpos_cmd)

     execute l:winpos_cmd

    sleep 10m
    call GUI#Maximize()

    call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
