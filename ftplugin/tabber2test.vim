call TQ84_log_indent(expand('<sfile>'))

set ai

call tq84#tabber2#init()

call tq84#tabber2#addExpansionRuleFunc(function('tq84#tabber2#expansionRuleWord', ['if',
  \ [ 'if !1! " {',
  \   '   !2!',
  \   'endif " }',
  \   '!3!']]))

call tq84#tabber2#addExpansionRuleFunc(function('tq84#tabber2#expansionRuleWord', ['out', ["dbms_output.put_line('!1!');!2!"]]))

call tq84#tabber2#addExpansionRuleFunc(function('tq84#tabber2#expansionRuleWord', ['exp', ["an expanded string!1!"]]))

call TQ84_log_dedent()
