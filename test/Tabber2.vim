call TQ84_log_indent('test/Tabber2.vim')

let s:fileExpected = expand('<sfile>:h') . '/a.tabber2test.expected'
" 2017-01-11
let s:fileGotten = tq84#test#newFile('a.tabber2test')

call TQ84_log(printf('files: expected=%s gotten=%s', s:fileExpected, s:fileGotten))

 
" fu! Type(i_or_a, txt)
"   execute 'normal ' a:i_or_a . a:txt
" endfu
  

" Do the actual typing...
 
call tq84#test#type("   if\t1=2\tfoo\nif\tx=y\techo 'x is equal to y'\tbar\tfini")
call tq84#test#type( nr2char(10) . "new line: out\thello word\t" . nr2char(10))
call tq84#test#type("if\tfoo=bar\tout\tfoo=bar\t\t")
call tq84#test#type("out\texp\t\t")

silent w

" Typing finished

" Compare expected and created (gotten) file:
if tq84#os#filesDiffer(s:fileGotten, s:fileExpected)
   echoerr 'NOT OK!!!!!'
else
   echomsg 'OK'
end

call TQ84_log_dedent()
