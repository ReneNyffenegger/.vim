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

   call Tabber#TabPressed()

endfu " }

fu! <SID>InsertOneTwoThree() " {

   call Tabber#Add([
     \ ['ins-const', 'One '  ],
     \ ['ins-const', 'Two '  ],
     \ ['ins-const', 'Three '],
     \ ])

   call Tabber#TabPressed()

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

new
  

if mapcheck('123') == ""
  inoremap  123 <ESC>:call <SID>InsertOneTwoThree()<CR>
endif

if mapcheck('fbb') == ""
  inoremap  fbb <ESC>:call <SID>InsertFooBarBaz()<CR>
endif

if mapcheck('h1') == ""
  inoremap  h1  <ESC>:call <SID>InsertH1Section()<CR>
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
         
"  Move forard to the div:
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

   execute "normal " . s:typed

   write! Tabber.out

   quitall!

endif
