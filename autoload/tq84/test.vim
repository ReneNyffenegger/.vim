call TQ84_log_indent(expand('<sfile>'))

fu! tq84#test#newFile(filenameWithoutPath) " {

"
" The function creates a 'temporary' buffer with the indicated
" filename (a:filenameWithoutPath). When the function returns,
" this new buffer is the current buffer.
"
" This function can be used instead of tempname() if the suffix
" of the file is important for setting the filetype.
"
" If the file is loaded into a buffer, the buffer is wiped out.
" If the file already exists, it's deleted.
" That is, when the function is called twice or more, each time you
" get a fresh new file.
"

  call TQ84_log_indent('tq84#test#newFile filenameWithoutPath=' . a:filenameWithoutPath)

  if isdirectory($TEMP) && filewritable($TEMP)
     let l:fileWithPath   = $TEMP . '/' . a:filenameWithoutPath
  else
     let l:fileWithPath   ='/tmp/' . a:filenameWithoutPath
  endif

  exe 'silent! bw! ' . l:fileWithPath
  
  if filereadable (l:fileWithPath)
     call  delete (l:fileWithPath)
  endif

  new
  exe 'e ' . l:fileWithPath

  call TQ84_log('returning ' . l:fileWithPath)
  call TQ84_log_dedent()

  return l:fileWithPath
endfu " }

fu! tq84#test#type(txt) " { This is the ore natural form, somehow...
  execute 'normal a' . a:txt
endfu " }
fu! tq84#test#typeI(txt) " { Insert text
  execute 'normal i' . a:txt
endfu " }

call TQ84_log_dedent()
