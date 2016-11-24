call TQ84_log_indent(expand('<sfile>'))

fu tq84#list#rmDup(list) " {
   call TQ84_log_indent(expand('<sfile>'))

 "
 " https://www.rosettacode.org/wiki/Remove_duplicate_elements#Vim_Script
 " Unfortunately, the order of elements is not preserved in this solution:
 "   call filter(a:list, 'count(a:list, v:val) == 1')
 "
 " See 
 "   http://stackoverflow.com/a/6630950/180275
 " for a solution when a:list is ordered.


   let l:seen = {}
   let l:ret  = []

   for l:item in a:list
       if ! has_key(l:seen, l:item)
          call add(l:ret, l:item)
          let l:seen[l:item] = 1
       endif
   endfor


   call TQ84_log_dedent()

   return l:ret

endfu " }

call TQ84_log_dedent()
