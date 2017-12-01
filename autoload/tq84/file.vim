call TQ84_log_indent(expand('<sfile>'))

fu! tq84#file#appendVisualSelection(filename) range " {
   call TQ84_log_indent('tq84#file#appendVisualSelection')
   execute "'<,'>w >> " . a:filename
   call TQ84_log_dedent()
endfu " }

fu! tq84#file#appendLine(filename, line) " {
   call TQ84_log_indent('tq84#file#appendLine')

   call tq84#buf#openScratch('scratch-append-line') 
  
   0put=a:line
   execute '1,$-1 w >> ' . a:filename

   bw!
   call TQ84_log_dedent()
endfu " }

call TQ84_log_dedent()
