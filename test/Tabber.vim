"
"    Use Tabber.bat to «call» this file.
"

"   Change to = 1 to test manually, without Tabber.bat
let s:manually = 0

fu! <SID>InsertFooBarBaz() " {

"    \ ['ins-const', 'Foo. press tab again '],
   call Tabber#Add([
     \ ['ins-const', 'Bar. type 123 '       ],
     \ ['ins-const', 'Baz. press tab again ']
     \ ])

   return 'Foo. press tab again '

endfu " }

fu! <SID>InsertOneTwoThree() " {

   call Tabber#Add([
     \ ['ins-const', 'One. press tab again '  ],
     \ ['ins-const', 'Two. press tab again '  ],
     \ ['ins-const', 'Three. press tab again '],
     \ ])

"  echo "go to insertmode and press tab"

   return 'EggsWhyZee '

endfu " }

new


if mapcheck('123') == ""
  inoremap <expr> 123 <SID>InsertOneTwoThree()
endif

if mapcheck('fbb') == ""
  inoremap <expr> fbb <SID>InsertFooBarBaz()
endif

if s:manually == 1
   echo "Go to insertmode and enter fbb"
else
   execute "normal ifbb a \t b 123 \t c \t d \t e \t f \t g<"

  write! Tabber.out

  quitall!

endif
