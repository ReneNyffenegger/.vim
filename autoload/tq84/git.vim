call TQ84_log_indent(expand("<sfile>"))
"
"   Compare with
"     http://vim.wikia.com/wiki/Version_Control_for_Vimfiles
"
"   NOTE:
"    I had to choose fnamemodify('%', ':p:h') to get the directory
"    in which the command should be executed because (at least) on
"    windows, links (created with mklink) weren't expanded with
"    expand(...)

fu! tq84#git#st() " {

    call TQ84_log_indent(expand("<sfile>"))

  " Note: only prints status of buffer.

    echo tq84#SystemInDir(resolve(expand('%:p:h')), 'git status ' . expand('%:t'))
    call TQ84_log_dedent()
endfu " }

fu! tq84#git#add() " {
    call TQ84_log_indent(expand("<sfile>"))

    echo tq84#SystemInDir(resolve(expand('%:p:h')), 'git add ' . expand('%:t'))

    call TQ84_log_dedent()
endfu " }

fu! tq84#git#ci() " {
    call TQ84_log_indent(expand("<sfile>"))

    call inputsave()
    let  l:commit_msg = input('Msg: ')
    call inputrestore()

    echo tq84#SystemInDir(resolve(expand('%:p:h')), 'git commit ' . expand('%:t') . ' -m "' . l:commit_msg . '"')

    call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
