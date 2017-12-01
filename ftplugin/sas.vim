call TQ84_log_indent(expand('<sfile>'))

vnoremap <buffer> <F8> :call tq84#file#appendVisualSelection('/share/home/tq84/sas/sas.redir')<cr><bar>:call tq84#file#appendLine('/share/home/tq84/sas/sas.redir','')<cr>
nnoremap <buffer> <F8> :call tq84#file#appendLine('/share/home/tq84/sas/sas.redir', getline('.'))<cr><bar>:call tq84#file#appendLine('/share/home/tq84/sas/sas.redir','')<cr>

call TQ84_log_dedent()
