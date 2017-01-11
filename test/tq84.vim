
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

if tq84#string#fromEnd('1234567890', 1) != '0' " {
   throw 'last character of 1234567890 is 0'
endif " }

if tq84#string#fromEnd('1234567890', 4) != '7890' " {
throw 'last 4 characters of 1234567890 are 7890'
endif " }

let s:txtFile = tq84#test#newFile('foo.txt')
call tq84#test#type('hello world' . nr2char(10))
call tq84#test#type('I am the great pretender' . nr2char(10))
exe 'normal k/pret/e' . nr2char(10)
if tq84#buf#wordLeftOfCursor() != 'pre'
   throw 'tq84#buf#wordLeftOfCursor returned ' . tq84#buf#wordLeftOfCursor() . ' instead of "pre"'
endif
exe 'silent! bw! ' . s:txtFile
