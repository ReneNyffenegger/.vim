
let s:list_with_dups=['one', 'two', 'one', 'three', 'two', 'three', 'two', 'one', 'two']
let s:list_without_dups=tq84#list#rmDup(s:list_with_dups)
if s:list_without_dups != ['one', 'two', 'three']
   throw 's:m != one, two, three'
endif

if ! tq84#os#filesDiffer('test/tq84.vim', 'test/a.tabber2test.expected')
   throw 'I have expected files to differ'
endif 

if has('unix')
   if tq84#os#correctPathSlashes('foo/bar\baz/one\two.txt') != 'foo/bar/baz/one/two.txt'
      throw 'wrong correction of path slashes'
   endif
else
   if tq84#os#correctPathSlashes('foo/bar\baz/one\two.txt') != 'foo\bar\baz\one\two.txt'
      throw 'wrong correction of path slashes'
   endif
endif

" { tq84#string

if tq84#string#fromEnd('1234567890', 1) != '0' " {
   throw 'last character of 1234567890 is 0'
endif " }

if tq84#string#fromEnd('1234567890', 4) != '7890' " {
throw 'last 4 characters of 1234567890 are 7890'
endif " }

" }

" { tq84#buf

let s:txtFile = tq84#test#newFile('foo.txt')
call tq84#test#type('hello world' . nr2char(10))
call tq84#test#type('I am the great pretender' . nr2char(10))
exe 'normal k/pret/e' . nr2char(10)
if tq84#buf#wordLeftOfCursor() != 'pre'
   throw 'tq84#buf#wordLeftOfCursor returned ' . tq84#buf#wordLeftOfCursor() . ' instead of "pre"'
endif
call tq84#buf#insertRightOfCursor('INSERTED')
if getline('.') != 'I am the great preINSERTEDtender'
   throw getline('.') . ' instead of "I am the great preINSERTEDtender"'
endif
if tq84#buf#lineRightOfCursor() != 'INSERTEDtender'
   throw 'tq84#buf#lineRightOfCursor() returned ' . tq84#buf#lineRightOfCursor() . ' instead of INSERTEDtender'
endif
if tq84#buf#lineLeftOfCursor() != 'I am the great pre'
throw 'tq84#buf#lineLeftOfCursor() returned ' . tq84#buf#lineLeftOfCursor() . ' instead of I am the great pre'
endif

" { tq84#buf#regexpAtCursor

normal o
call tq84#test#type('foo → abc-22-def and → ghi-42-jkl or more')

fu! GoToColumnAndTestRegexp(col, expected) " {
  exe 'normal ' . a:col . '|'

  let l:regexp = '→ *\zs\w+-\d+-\w+'
" let l:regexp = '\w+-\d+-\w+'
  if tq84#buf#regexpAtCursor(l:regexp) != a:expected
     throw 'problem at ' . a:col . ': found ' . tq84#buf#regexpAtCursor(l:regexp)
  endif
endfu " }

call GoToColumnAndTestRegexp( 1, '')
call GoToColumnAndTestRegexp( 3, '')
call GoToColumnAndTestRegexp( 4, '')
call GoToColumnAndTestRegexp( 5, 'abc-22-def')
call GoToColumnAndTestRegexp( 6, 'abc-22-def')
call GoToColumnAndTestRegexp( 7, 'abc-22-def')
call GoToColumnAndTestRegexp(14, 'abc-22-def')
call GoToColumnAndTestRegexp(15, 'abc-22-def')
call GoToColumnAndTestRegexp(16, 'abc-22-def')
call GoToColumnAndTestRegexp(17, '')
call GoToColumnAndTestRegexp(21, '')
call GoToColumnAndTestRegexp(22, 'ghi-42-jkl')
call GoToColumnAndTestRegexp(33, 'ghi-42-jkl')
call GoToColumnAndTestRegexp(34, '')


" }

exe 'silent! bw! ' . s:txtFile

" }
