call TQ84_log_indent(expand('<sfile>'))

syntax case match

syntax    match bibelComment /#.*/
syntax    match bibelVers    /\v^[^|]+|\|/

highlight bibelVers guifg=#999999

highlight link  bibelComment Comment
highlight link  bibelVers    bibelVers

call TQ84_log_dedent()
