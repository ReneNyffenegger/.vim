call TQ84_log_indent(expand('<sfile>'))

nnoremap <buffer> <F3>      :let @+ = '@"'.expand('%:p').'"'.nr2char(10)<CR>:w<CR>
inoremap <buffer> <F3> <ESC>:let @+ = '@"'.expand('%:p').'"'.nr2char(10)<CR>:w<CR>

set foldmarker=\ {,\ }
set foldmethod=marker
set foldtext=getline(v:foldstart)
set commentstring=\ --%s

" Add clipboard's content below current cursor position with leading --
" nnoremap <buffer> <F7> :call append('.', extend(map(extend([''], split(@+, "\n")), "'-- ' . v:val"), ['']))<CR>
  nnoremap <buffer> <F7> :call append('.',        map(extend([''], split(@+, "\n")), "'-- ' . v:val")       )<CR>

call tq84#tabber2#init()
call tq84#tabber2#addExpansionRuleFunc(function('tq84#tabber2#expansionRuleWord', ['out', ["dbms_output.put_line('!1!');!2!"]]))
call tq84#tabber2#addExpansionRuleFunc(function('tq84#tabber2#expansionRuleWord', ['cor', ["create or replace !1!"]]))
call tq84#tabber2#addExpansionRuleFunc(function('tq84#tabber2#expansionRuleWord', ['prc', [
\ 'procedure !1!(!2!) is',
\ '  !3!',
\ 'begin',
\ '  !5!',
\ 'end !4!;']]))

call TQ84_log_dedent()
