" 
"  TODO:  https://github.com/ReneNyffenegger/open-browser.vim/blob/master/plugin/openbrowser.vim
"

call TQ84_log_indent(expand("<sfile>"))

fu OpenUrl#Go(url) " {

  call TQ84_log_indent(expand("<sfile>") . "-OpenUrl#Go: " . a:url)
  let use_mozilla = 1

  let l:url = substitute(a:url, '#', '\\#', 'g')
  let l:url = substitute(l:url, '&', '^&' , 'g')


  call TQ84_log("url = " . l:url)

  if use_mozilla == 1
"   let d = system("\"c:\\Program Files\\Mozilla Firefox\\firefox.exe\" -url " . a:url )
    execute "silent !start cmd /c start firefox -url " . l:url
  else
"   let d = system("start chrome.exe " . a:url)
    execute "silent !start cmd /c start chrome  " . l:url
  endif

  call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
