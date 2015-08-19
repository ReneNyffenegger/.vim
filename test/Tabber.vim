"
"    Use Tabber.bat to «call» this file.
"

"   Change to = 1 to test manually, without Tabber.bat
let s:manually = 0

fu! <SID>InsertFooBarBaz() " {

   call Tabber#Add([
     \ ['ins-const', 'Foo '],
     \ ['ins-const', 'Bar '],
     \ ['ins-const', 'Baz ']
     \ ])

   normal i
   call Tabber#TabPressed()

endfu " }

fu! <SID>InsertOneTwoThree() " {

 call TQ84_log_indent(expand('<sfile>') . ' .: ' . virtcol('.') . ', $: ' . virtcol('$')) 

   call Tabber#Add([
     \ ['ins-const', 'One '  ],
     \ ['ins-const', 'Two '  ],
     \ ['ins-const', 'Three '],
     \ ])

   call Tabber#TabPressed()

   call TQ84_log_dedent()

   return ''

endfu " }

fu! <SID>InsertH1Section() " {

  let l:jumpTo_1 = Tabber#MakeJumpToMark()
  let l:jumpTo_2 = Tabber#MakeJumpToMark()
  let l:jumpTo_3 = Tabber#MakeJumpToMark()

  call Tabber#InsertUnindentedSkeleton(
  \ ['  <h1>'    . l:jumpTo_1 . '</h1><!--{-->',
  \  '    <div>' . l:jumpTo_2 . '</div>',
  \  '    '      . l:jumpTo_3,
  \  '  <!--}-->'
  \ ])

  call Tabber#Add([
     \ ['jump-to', l:jumpTo_1 ],
     \ ['jump-to', l:jumpTo_2 ],
     \ ['jump-to', l:jumpTo_3 ]
     \ ])

  call Tabber#TabPressed()

endfu " }

fu! <SID>InsertUnindentedSkeleton_2() " {

  let l:jumpTo_1 = Tabber#MakeJumpToMark()
  let l:jumpTo_2 = Tabber#MakeJumpToMark()

  call Tabber#InsertUnindentedSkeleton(
  \ ['  IUS '    . l:jumpTo_1      ,
  \  '  ius '    . l:jumpTo_2 . '<',
  \ ])

  call Tabber#Add([
     \ ['jump-to', l:jumpTo_1 ],
     \ ['jump-to', l:jumpTo_2 ],
     \ ])

  call Tabber#TabPressed()

endfu " }

fu! <SID>InsertAnotherUnInSkel() " {

  let l:jumpTo_1 = Tabber#MakeJumpToMark()
  let l:jumpTo_2 = Tabber#MakeJumpToMark()

  call Tabber#InsertUnindentedSkeleton(
  \ ['  EnEnEnTop ['    . l:jumpTo_1 . ']', 
  \  '  EnEnEnBottom [' . l:jumpTo_2 . ']',
  \ ])

  call Tabber#Add([
     \ ['jump-to', l:jumpTo_1 ],
     \ ['jump-to', l:jumpTo_2 ],
     \ ])

  normal i
  call Tabber#TabPressed()

endfu " }

fu! <SID>InsertIfElse() " {
  call TQ84_log_indent(expand('<sfile>'))

  let l:jumpTo_1 = Tabber#MakeJumpToMark()
  let l:jumpTo_2 = Tabber#MakeJumpToMark()
  let l:jumpTo_3 = Tabber#MakeJumpToMark()
  let l:jumpTo_4 = Tabber#MakeJumpToMark()

  call Tabber#InsertIndentedSkeleton([
     \ 'if (' . l:jumpTo_1 . ') {',
     \ '  ' . l:jumpTo_2          ,
     \ '}'                        ,
     \ 'else {'                   ,
     \ '  ' . l:jumpTo_3          ,
     \ '}'                        ,
     \ l:jumpTo_4 ])


  call Tabber#Add([
     \ ['jump-to', l:jumpTo_1 ],
     \ ['jump-to', l:jumpTo_2 ],
     \ ['jump-to', l:jumpTo_3 ],
     \ ['jump-to', l:jumpTo_4 ]
     \ ])

    
  normal i
  call Tabber#TabPressed()
  
  call TQ84_log_dedent()

  return ''
endfu " }

new
  

if mapcheck('123') == ""
  inoremap  <buffer> 123 =<SID>InsertOneTwoThree()<CR>
endif

if mapcheck('fbb') == ""
  inoremap  <buffer> fbb <ESC>:call <SID>InsertFooBarBaz()<CR>
endif

if mapcheck('h1') == ""
  inoremap  <buffer> h1  <ESC>:call <SID>InsertH1Section()<CR>
endif

if mapcheck('ius2') == ""
  inoremap  <buffer> ius2 <ESC>:call <SID>InsertUnindentedSkeleton_2()<CR>
endif

if mapcheck(',nnn') == ""
  nnoremap  <buffer> ,nnn <ESC>:call <SID>InsertAnotherUnInSkel()<CR>
endif

if mapcheck(',ie') == ""
  inoremap  <buffer> ,ie =<SID>InsertIfElse()<CR>
endif

if s:manually == 1
   echo "Go to insertmode and enter fbb or 123 or h1 or so."
else

   let s:typed = ''

  
"  Insert eight lines
   let s:typed = s:typed . "iline 1\nline 2\nline 3\nline 4\nline 5\nline 6\nline 7\nline 8"

"  Go to «line 5», mark with a star
   let s:typed = s:typed . "/line 5\ni* "

"  insert a h1"
   let s:typed = s:typed . "h1"
   
"  The text between h1 and /h1 is ...
"     ... __H1H1__
   let s:typed = s:typed . "__H1H1__"
   
"      ... followed by the expansion of 123 
"          Note, after the tabulators, there is also a hyphen, so that
"          the resulting string is
"          One -Two -Three
   let s:typed = s:typed . "123-\t-\t"
         
"  Move forward to the div:
   let s:typed = s:typed . "\t"

"  and enter __DIV_DIV__
   let s:typed = s:typed . "__DIV_DIV__"
         
"  Move forward, after the <div>
   let s:typed = s:typed . "\t"
   
"  and write
   let s:typed = s:typed . "after H1\t\t\t<"

"  Go to «line 7»
   let s:typed = s:typed . "/line 7\n"

"  Add three empty lines
   let s:typed = s:typed . "3o"

"  go up one line
   let s:typed = s:typed . "k"

"  add another h1
   let s:typed = s:typed . "ih1XXX\tYYYY\tZZZZ"

"  Go to «line 2»
   let s:typed = s:typed . "/line 2\n"

"  Add an unindented skeleton, test whether a jump
"  mark at the end is treated correctly:
   let s:typed = s:typed . "iius2ENTER-1\tENTER-2"

"  Go to last line
   let s:typed = s:typed . "$G"

"  Append lines with initial spacing
   let s:typed = s:typed . "o     Space intentionally left blank\n"
   let s:typed = s:typed . "123,\t,\t,\t<"
   
"  Try to execute a normal-mode-mapping
"      ... go one line up, first
   let s:typed = s:typed . "k"

"      ... then execute mapping
   let s:typed = s:typed . ",nnn"

"      ... the write into first [...]
   let s:typed = s:typed . "first\t"

"      ... the write into second [...]
   let s:typed = s:typed . "second\tthird"

"  Try if else

"  Go to last line
   let s:typed = s:typed . '$G'

"      ... go to insert mode
   let s:typed = s:typed . 'i'

   let s:typed = s:typed . ",ie2==2\t,ie3==3\tprint(2==2 and 3==3)\tprint(2==2 and 2!=3)\t// some comment\tprint (2!=2)\t// end if else"

   execute "normal " . s:typed

   write! Tabber.out

   quitall!

endif
