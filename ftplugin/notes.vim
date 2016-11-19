call TQ84_log_indent(expand('<sfile>'))

try

" Use forward slashes
call TQ84_log('set shellslash, was ' . &shellslash)
setl shellslash

" http://vi.stackexchange.com/questions/7478/how-do-i-exclude-the-%E2%86%92-from-file-name-characters
call TQ84_log('set includeexpr, was ' . &includeexpr)
set includeexpr=substitute(v:fname,'^→','','')

call TQ84_log('set ff=unix, was ' . &ff)
set ff=unix


catch

  call TQ84_log('caught: ' . v:exception)

endtry

call TQ84_log_dedent()
