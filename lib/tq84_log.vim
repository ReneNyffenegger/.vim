if "use_log" == "use_log" " {

" let s:log_indent = 0
  let s:tq84_log_array = []

  if   isdirectory($TEMP) && filewritable($TEMP)
         let g:tq84_log_file_name   = $TEMP . "/vim_log_" . strftime('%Y-%m-%d_%H-%M-%S')
  elseif isdirectory($HOME) && filewritable($HOME)
         let g:tq84_log_file_name   = $HOME . "/vim_log_" . strftime('%Y-%m-%d_%H-%M-%S')
  else
       let g:tq84_log_file_name   =          "/vim_log_" . strftime('%Y-%m-%d_%H-%M-%S')
  endif

" let g:tq84_log_file_mode   ='file'
  let g:tq84_log_file_mode   ='memory'


fu! TQ84_log_init() " {
  
   if g:tq84_log_file_mode == 'file' " {
      let l:cur_buf_nr = bufnr('%')
      execute 'silent new ' . g:tq84_log_file_name
    
    " setlocal buftype=nofile bufhidden=hide noswapfile 
      setlocal                bufhidden=hide noswapfile 
    
      silent w
      let g:tq84_log_file_buf_nr = bufnr('%')
      silent close
      execute 'buffer ' . l:cur_buf_nr
   " }
   elseif g:tq84_log_file_mode == 'memory' " {
      let g:tq84_log_memory_lines = []
   endif " }

endfu " }
fu! TQ84_log (S) " {
 
    let l:s_ = strftime('%Y-%m-%d %H:%M:%S ') . repeat('  ', len(s:tq84_log_array)) . a:S
" 
    if g:tq84_log_file_mode == 'file' " {
   
       let l:cur_buf_nr = bufnr('%')
       execute 'buffer ' . g:tq84_log_file_buf_nr
    
    "  normal $G
    "  execute 'o' . l:s_
       call append('$', l:s_)
       let l:line=line('$')
    
       silent w
    
       execute 'silent buffer ' . l:cur_buf_nr
       return l:line
    " }
    elseif g:tq84_log_file_mode == 'memory' " {
       call add(g:tq84_log_memory_lines, l:s_)
       return len(g:tq84_log_memory_lines) - 1
      
    endif " }
 
"  " http://stackoverflow.com/a/23090321/180275
"  " ------------------------------------------
"  " new
"  " setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
"  " put=l:s_
"  " execute 'w >>' g:tq84_log_file_name
" 
"   
"   "   silent execute "!echo " . s_ . ">> " . g:tq84_log_file_name
"   
"   "  Append file ----- {
"   "     try
"   "       let l:f = readfile(g:tq84_log_file_name)
"   "     catch /E484:/
"   "     " «Can't read file...»
"   "       let l:f = []
"   "     endtry
"   "
"   "     call add(l:f, l:s_)
"   "     call writefile(l:f, g:tq84_log_file_name)
"   "     
"   "     return len(l:f)
"   "  ----- }
"   
"   "    perl << EOF
"   "
"   "    open($f, '>>', 'c:/temp/vim_log');
"   "    print $f "test\n";
"   "    close $f;
" "EOF
" 
endfu " }
fu! TQ84_log_indent(S) " {

  let l:line = TQ84_log('time: ? ' . a:S . ' ' . nr2char(123))
  call add(s:tq84_log_array, {'reltime': reltime(), 'line': l:line})

endfu! " }
fu! TQ84_log_getline(line) " {


    if g:tq84_log_file_mode == 'file' " {
       let l:cur_buf_nr = bufnr('%')
       execute 'buffer ' . g:tq84_log_file_buf_nr

       let l:line_text = getline(a:line)
  
       execute 'silent buffer ' . l:cur_buf_nr

       return l:line_text
       
    " }
    elseif g:tq84_log_file_mode == 'memory' " {
       return g:tq84_log_memory_lines[a:line]
    endif " }


endfu " }
fu! TQ84_log_setline(line, text) " {
    if g:tq84_log_file_mode == 'file' " {
       let l:cur_buf_nr = bufnr('%')
       execute 'buffer ' . g:tq84_log_file_buf_nr

       execute setline(a:line, a:text)
  
       execute 'silent buffer ' . l:cur_buf_nr
       
    " }
    elseif g:tq84_log_file_mode == 'memory' " {
       let g:tq84_log_memory_lines[a:line] = a:text
    endif " }

endfu " }
fu! TQ84_log_dedent() " {

  let l:indent_start_entry = remove(s:tq84_log_array, -1)
  let l:time_for_indent    = reltimestr(reltime(l:indent_start_entry['reltime']))

  let l:indent_opening_line = TQ84_log_getline(l:indent_start_entry['line'])
  let l:indent_opening_line = substitute (l:indent_opening_line, 'time: ?', 'time: ' . l:time_for_indent, '')

  call TQ84_log_setline(l:indent_start_entry['line'], l:indent_opening_line)

  call TQ84_log(nr2char(125))

endfu! " }
fu! TQ84_log_clear() " {

   if g:tq84_log_file_mode == 'file' " {

     let l:cur_buf_nr = bufnr('%')
     execute 'buffer ' . g:tq84_log_file_buf_nr
    
"    call writefile([], g:tq84_log_file_name)
     execute 'e ' . tq84_log_file_name
     %d
     w

     execute 'buffer ' . l:cur_buf_nr
   " }
   else " {

      let g:tq84_log_memory_lines = []
    " 2015-10-09: emptying s:tq84_log_array, too:
      let l:tq84_log_array = []

      call TQ84_log_flush()

   endif " }

endfu " }
fu! TQ84_log_flush() " {

  if g:tq84_log_file_mode == 'memory'
      call writefile(g:tq84_log_memory_lines, g:tq84_log_file_name)
  endif

endfu " }
fu! TQ84_log_open_log() " {
    call TQ84_log_flush()
    execute 'e! ' . g:tq84_log_file_name
endfu " }

nnoremap      ,opvil     :call TQ84_log_open_log()<CR>
nnoremap      ,rmvil     :call TQ84_log_clear()<CR>

" }
else " {
fu! TQ84_log_init   ( )
endfu
fu! TQ84_log        (S)
endfu
fu! TQ84_log_indent (S)
endfu
" fu! TQ84_log_getline(line)
" Only used within TQ84_log functions, anyway.
" endfu
fu! TQ84_log_dedent ( )
endfu
fu! TQ84_log_clear  ( )
endfu

endif " }
