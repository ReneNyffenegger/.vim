call TQ84_log_indent(expand('<sfile>'))

if !exists('g:use_tabber') || g:use_tabber == 0
    call TQ84_log('finishing because of g:use_tabber')
    call TQ84_log_dedent()
    finish
endif

call TQ84_log('g:use_tabber = ' . g:use_tabber)

inoremap <expr> <TAB> Tabber#TabPressed()

call TQ84_log_dedent()
