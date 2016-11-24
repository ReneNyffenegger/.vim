call TQ84_log_indent(expand('<sfile>'))

let s:options = [
\ 'autoindent'    ,
\ 'commentstring' ,
\ 'compatible'    ,
\ 'grepprg'       ,
\ 'guifont'       ,
\ 'relativenumber',
\ 'runtimepath'   ,
\ 'wildchar'      ,
\ 'wildignore'    ,
\ 'visualbell'    ,
\ 'wrap'          ]

fu tq84#option#log() " {
   call TQ84_log_indent(expand('<sfile>'))

   for s:option in s:options
       if s:option == 'runtimepath'
          continue
       endif
       call TQ84_log(printf('%-18s: %s', s:option, eval('&' . s:option)))
   endfor

   call TQ84_log_indent('runtimepath') " {
        for s:rtp in split(&rtp, ',')
            call TQ84_log(s:rtp)
        endfor
   call TQ84_log_dedent() " }

   call TQ84_log_dedent()
endfu " }

fu tq84#option#values() " {
   call TQ84_log(expand('<sfile>'))

   return map(copy(s:options), 'eval("&" . v:val)')

endfu " }

fu tq84#option#diff(values_1, values_2) " {

   call TQ84_log_indent(expand('<sfile>'))

   let l:cnt = 0

   for l:opt in s:options

       if a:values_1[l:cnt] != a:values_2[l:cnt]
          call TQ84_log(l:opt . ' has changed from ' . a:values_1[l:cnt] . ' to ' . a:values_2[l:cnt])
       endif

       let l:cnt = l:cnt + 1

   endfor

   call TQ84_log_dedent()
   
endfu " }

call TQ84_log_dedent()
