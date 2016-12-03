let s:fileExpected = expand('<sfile>:h') . '/a.tabber2test.expected'
let s:fileGotten   = $TEMP . '/a.tabber2test'

exe 'silent! bw! ' . s:fileGotten

if filereadable (s:fileGotten)
   call  delete (s:fileGotten)
endif
 
fu! Type(txt)
  execute 'normal i' . a:txt
endfu
  
new
exe 'e ' . s:fileGotten

" Do the actual typing...
 
call Type("   if\t1=2\tfoo\nif\tx=y\techo 'x is equal to y'\tbar\tfini")

silent w

" Typing finished

" Compare expected and created (gotten) file:
if tq84#os#filesDiffer(s:fileGotten, s:fileExpected)
   echoerr 'NOT OK!!!!!'
else
   echomsg 'OK'
end
