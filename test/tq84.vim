
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
