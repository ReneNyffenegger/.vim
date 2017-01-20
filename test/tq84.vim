
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
exe 'silent! bw! ' . s:txtFile

" }
