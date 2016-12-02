" let s:bufnr=bufnr('c:\temp\a.tabber2test')
" if s:bufnr != -1
silent! bw!       c:\temp\a.tabber2test
if filereadable ('c:\temp\a.tabber2test')
   echo "deleting c:\temp\a.tabber2test"
   call  delete ('c:\temp\a.tabber2test')
   let g:FF = expand('<sfile>:p')
endif
 
fu! Type(txt)
  execute 'normal i' . a:txt
endfu
  
new
e c:\temp\a.tabber2test
 
call Type("   if\t1=2\tfoo\nif\tx=y\techo 'x is equal to y'\t\bar\tfini")

silent w


let s:fc = 'fc c:\temp\a.tabber2test ' . expand('<sfile>:h') . '\a.tabber2test.expected'
let s:diffOut = system(s:fc)

if match(s:diffOut, 'FC: Keine Unterschiede gefunden') == -1
   echoerr s:diffOut
else
   echomsg 'OK'
endif
