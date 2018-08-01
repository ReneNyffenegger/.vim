call TQ84_log_indent(expand('<sfile>'))

fu! tq84#vba#cleanSourceCode() " {

  %s/\<As\>/as/ge
  %s/\<Declare\>/declare/ge
  %s/\<Dim\>/dim/ge
  %s/\<End\>/end/ge
  %s/\<False\>/false/ge
  %s/\<Integer\>/integer/ge
  %s/\<Set\>/set/ge
  %s/\<True\>/true/ge
  %s/\<With\>/with/ge

endfu " }

call TQ84_log_dedent()
