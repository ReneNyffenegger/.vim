call TQ84_log_indent('test/Tabber2.vim')

let s:fileExpected = expand('<sfile>:h') . '/a.tabber2test.expected'
if isdirectory($TEMP) && filewritable($TEMP)
   let s:fileGotten   = $TEMP . '/a.tabber2test'
else
   let s:fileGotten   ='/tmp/a.tabber2test'
endif

call TQ84_log(printf('files: expected=%s gotten=%s', s:fileExpected, s:fileGotten))

exe 'silent! bw! ' . s:fileGotten

if filereadable (s:fileGotten)
   call  delete (s:fileGotten)
endif
 
fu! Type(i_or_a, txt)
  execute 'normal ' a:i_or_a . a:txt
endfu
  
new
exe 'e ' . s:fileGotten

" Do the actual typing...
 
call Type('i', "   if\t1=2\tfoo\nif\tx=y\techo 'x is equal to y'\tbar\tfini")
" call Type('a',  nr2char(10) . "new line: out\t")

silent w

" Typing finished

" Compare expected and created (gotten) file:
if tq84#os#filesDiffer(s:fileGotten, s:fileExpected)
   echoerr 'NOT OK!!!!!'
else
   echomsg 'OK'
end

call TQ84_log_dedent()
