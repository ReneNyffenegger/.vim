call TQ84_log_indent(expand('<sfile>'))

" { Mappings

if 0 " SQL*Plus environment
   nnoremap <buffer> <F3>      :let @+ = '@"'.expand('%:p').'"'.nr2char(10)<CR>:w<CR>
   inoremap <buffer> <F3> <ESC>:let @+ = '@"'.expand('%:p').'"'.nr2char(10)<CR>:w<CR>
else
   nnoremap <buffer> <F3>      :let @+ =      expand('%:p').'"'.nr2char(10)<CR>:w<CR>
   inoremap <buffer> <F3> <ESC>:let @+ =      expand('%:p').'"'.nr2char(10)<CR>:w<CR>
endif

nnoremap <buffer> <C-F4>    :call tq84#ft#sql#yankCurStmtAndGoToNext()<CR>

" Add clipboard's content below current cursor position with leading --
" nnoremap <buffer> <F7> :call append('.', extend(map(extend([''], split(@+, "\n")), "'-- ' . v:val"), ['']))<CR>
  nnoremap <buffer> <F7> :call append('.',        map(extend([''], split(@+, "\n")), "'-- ' . v:val")       )<CR>
  
nnoremap ,stfm :call tq84#ft#sql#formatStmt()<CR>

" }

set foldmarker=\ {,\ }
set foldmethod=marker
set foldtext=getline(v:foldstart)
set commentstring=\ --%s

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
