"
"    Use Tabber.bat to «call» this file.
"

"   Change to = 1 to test manually, without Tabber.bat
let s:manually = 0

fu! <SID>InsertFooBarBaz() " {

"    \ ['ins-const', 'Foo. press tab again '],
   call Tabber#Add([
     \ ['ins-const', 'Bar. type 12 then 3'  ],
     \ ['ins-const', 'Baz. press tab again ']
     \ ])

   call GUI#InsertModeInsertText('Foo. press tab again ')

endfu " }

fu! <SID>InsertOneTwoThree() " {

   call Tabber#Add([
     \ ['ins-const', 'One. press tab again '  ],
     \ ['ins-const', 'Two. press tab again '  ],
     \ ['ins-const', 'Three. press tab again '],
     \ ])

   call GUI#InsertModeInsertText('EggsWhyZee')

endfu " }

fu! <SID>InsertH1Section() " {

  let l:jumpTo_1 = Tabber#MakeJumpToMark()
  let l:jumpTo_2 = Tabber#MakeJumpToMark()

  call Tabber#InsertUnindentedSkeleton(
  \ ['  <h1>'    . l:jumpTo_1 . '</h1>  <!--{-->',
  \  '    <div>' . l:jumpTo_2 . '</div>',
  \  '  <!--}-->'
  \ ])

  call Tabber#Add([
     \ ['jump-to', l:jumpTo_1 ],
     \ ['jump-to', l:jumpTo_2 ]
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
   echo "Go to insertmode and enter fbb"
else
   execute "normal iline 1\nline 2\nline 3\nkkih1fbb a \t b 123 \t c \t d \t e \t f \t g<"

  write! Tabber.out

  quitall!

endif
