
let s:list_with_dups=['one', 'two', 'one', 'three', 'two', 'three', 'two', 'one', 'two']
let s:list_without_dups=tq84#list#rmDup(s:L)
if s:list_without_dups != ['one', 'two', 'three']
   throw 's:m != one, two, three'
endif
