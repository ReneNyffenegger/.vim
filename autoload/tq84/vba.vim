call TQ84_log_indent(expand('<sfile>'))

fu! tq84#vba#cleanSourceCode() " {

  %s/\<Alias\>/alias/ge
  %s/\<As\>/as/ge
  %s/\<Boolean\>/boolean/ge
  %s/\<Byte\>/byte/ge
  %s/\<ByVal\>/byVal/ge
  %s/\<ByRef\>/byRef/ge
  %s/\<Call\>/call/ge
  %s/\<Case\>/case/ge
  %s/\<Const\>/const/ge
  %s/\<Debug\.Print\>/debug.print/ge
  %s/\<Declare\>/declare/ge
  %s/\<Dim\>/dim/ge
  %s/\<Do While\>/do while/ge
  %s/\<End\>/end/ge
  %s/\<Else\>/else/ge
  %s/\<ElseIf\>/elseIf/ge
  %s/\<Erase\>/erase/ge
  %s/\<Exit\>/exit/ge
  %s/\<False\>/false/ge
  %s/\<For\>/for/ge
  %s/\<Function\>/function/ge
  %s/\<If\>/if/ge
  %s/\<InStr\>/instr/ge
  %s/\<Integer\>/integer/ge
  %s/\<Len\>/len/ge
  %s/\<LenB\>/lenB/ge
  %s/\<Lib\>/lib/ge
  %s/\<Long\>/long/ge
  %s/\<LongPtr\>/longPtr/ge
  %s/\<Loop\>/loop/ge
  %s/\<Mid\>/mid/ge
  %s/\<Next\>/next/ge
  %s/\<Option Explicit\>/option explicit/ge
  %s/\<Optional\>/optional/ge
  %s/\<Private\>/private/ge
  %s/^Public\>/public/ge
  %s/\<ReDim\>/redim/ge
  %s/\<Select\>/select/ge
  %s/\<Set\>/set/ge
  %s/\<Str\>/str/ge
  %s/\<String\>/string/ge
  %s/\<Sub\>/sub/ge
  %s/\<Then\>/then/ge
  %s/\<To\>/to/ge
  %s/\<Trim\>/trim/ge
  %s/\<True\>/true/ge
  %s/\<Type\>/type/ge
  %s/\<Val\>/val/ge
  %s/\<With\>/with/ge

endfu " }

call TQ84_log_dedent()
