call TQ84_log_indent(expand('<sfile>'))

fu! tq84#ft#sql#stmtStartLine() " {
    call TQ84_log_indent('tq84#ft#sql#stmtStartLine')

    let l:posSafe = getcurpos()

    let l:line = search(';','bWe')
    call TQ84_log('l:line = ' . l:line)

    if l:line == 0
       let l:line = 1
    else
       let l:line = l:line + 1
    endif
"   call TQ84_log('normal ' . l:line . 'G')

    exe 'normal ' . l:line . 'G'
    let l:line =  search('\w', 'W')
    call setpos('.', l:posSafe)

    call TQ84_log('returning ' . l:line)
    call TQ84_log_dedent()

    return l:line
endfu " }

fu! tq84#ft#sql#stmtEndLine() " {
    call TQ84_log_indent('tq84#ft#sql#stmtEndLine')

    let l:posSafe = getcurpos()

    let l:line = search(';','We')

    if l:line == 0
       let l:line = line('$')
    endif

    call setpos('.', l:posSafe)

    call TQ84_log('returning ' . l:line)
    call TQ84_log_dedent()

    return l:line

endfu " }

fu! tq84#ft#sql#yankCurStmtAndGoToNext() " {
    call TQ84_log_indent('tq84#ft#sql#yankCurStmtAndGoToNext')

    let l:stmtStartLine = tq84#ft#sql#stmtStartLine()
    let l:stmtEndLine   = tq84#ft#sql#stmtEndLine()

    exe l:stmtStartLine . ',' . l:stmtEndLine . 'y+'

    exe 'normal ' . (l:stmtEndLine+1) . 'G'

    call search('\w', 'W')

    call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
