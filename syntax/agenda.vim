call TQ84_log_indent(expand('<sfile>'))

syntax case match

syntax match M_agendaTodo   /\<TODO\w*/
syntax match M_agendaTodoRN /\<TODO_RN\w*/
syntax match M_agendaDone   /\<DONE\w*/
syntax match M_agendaTime   /^ *\d\d:\d\d\D/

highlight HL_agendaTodo         guifg=#ff3333
highlight HL_agendaTodoRN       guifg=#ff7722
highlight HL_agendaDone         guifg=#007700
highlight HL_agendaTime         gui=bold

highlight link M_agendaTodo     HL_agendaTodo
highlight link M_agendaTodoRN   HL_agendaTodoRN
highlight link M_agendaDone     HL_agendaDone
highlight link M_agendaTime     HL_agendaTime

call TQ84_log_dedent()
