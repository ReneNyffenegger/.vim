call TQ84_log_indent(expand('<sfile>'))

" Use forward slashes
set shellslash

" http://vi.stackexchange.com/questions/7478/how-do-i-exclude-the-%E2%86%92-from-file-name-characters
set includeexpr=substitute(v:fname,'^→','','')

set ff=unix

call TQ84_log_dedent()
