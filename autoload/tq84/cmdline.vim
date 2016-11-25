call TQ84_log_indent(expand('<sfile>'))

fu tq84#cmdline#cutPathTail() " {

   call TQ84_log_indent(expand('<sfile>'))

   let l:cmdline = getcmdline()

   call TQ84_log('cmdline=' . l:cmdline)

   if getcmdtype() != ':'
      call TQ84_log('returning because cmd type is ' . getcmdtype())
      call TQ84_log_dedent()
      return l:cmdline
   endif
 
 
   if l:cmdline[0] !=# 'e' " {
      call TQ84_log('l:cmdline[0] != "e", returning')
      call TQ84_log_dedent()

      return l:cmdline
   endif " }
 
 " The command line is something like
 "
 "   :e \foo\bar\baz.xyz.txt
 "
 " The Function now tries to cut that last part of the path, so that
 " the command line reads
 "
 "   :e \foo\bar\

   let l:ret = l:cmdline

   call TQ84_log('last character in command line: ' . l:ret[-1:])

   if l:ret[-1:] == '/' || l:ret[-1:] == '\'
      call TQ84_log('last character is forward or backward slash')
      let l:ret = l:ret[0:-2]
      call TQ84_log('l:ret changed to ' . l:ret . '<')
   endif

   let l:ret = fnamemodify(l:ret, ':h')
   call TQ84_log('l:ret = ' . l:ret)
   let l:slash =  has('unix') ? '/' : '\'
   call TQ84_log('l:slash = ' . l:slash)
 
 
   call TQ84_log_dedent()
   return l:ret . l:slash

endfu " }

call TQ84_log_dedent()
