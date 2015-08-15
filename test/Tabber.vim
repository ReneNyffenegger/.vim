"
"    Use Tabber.bat to «call» this file.
"

"   Change to = 1 to test manually, without Tabber.bat
let s:manually = 0

fu! TabberTestStepOne()

   call Tabber#Add([
     \ ['ins-const', 'Foo. press tab again '],
     \ ['ins-const', 'Bar. type xyz '       ],
     \ ['ins-const', 'Baz. press tab again ']
     \ ])

endfu

fu! TabberTestStepTwo()

   call Tabber#Add([
     \ ['ins-const', 'One. press tab again '  ],
     \ ['ins-const', 'Two. press tab again '  ],
     \ ['ins-const', 'Three. press tab again '],
     \ ])

   echo "go to insertmode and press tab"

   return 'EggsWhyZee '

endfu

new


if mapcheck('xyz') == ""
  inoremap <expr> xyz TabberTestStepTwo()
endif

call TabberTestStepOne()

if s:manually == 1
   echo "Go to insertmode and press tab"
else
   execute "normal i\t a \t b xyz \t c \t d \t e \t f \t g<"

  write! Tabber.out

  quitall!

endif
