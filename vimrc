set encoding=utf8       " {
"   At the very start, so that the various mappings involving
"   the Meta key (Alt) work, at least on windows, that is.
"   }

set rtp+=$git_work_dir\vim\vimfiles
set rtp+=$git_work_dir\vim\vimfiles\after

" Log functions {
:runtime lib\tq84_log.vim
call TQ84_log_init()
" }

call TQ84_log_indent(expand("<sfile>"))

set nocompatible        " {
"   This options sets/modifies other options!
"   Note, the option is set anyway when a (g)vimrc file is found
"   }

" { Bare minimum settings

set hidden
set lazyredraw      "   Don't update display while executing macros.
set nowrap
set linebreak       "   Only used when a text is «wrapped» (set wrap): prevents words from being broken in the middle.
set bs=2            "   allow backspacing over everything in insert mode

" Filetype related {
call TQ84_log_indent('filetype on') " {
filetype on 
" -----------
" This command loads (on Windows)
"   $VIMRUNTIME/filetype.vim
" that defines autocommands for the BufNewFile and BufRead
" event. For example, the file contains
"
"   au BufNewFile,BufRead *.java,*.jav		setf java
"
call TQ84_log_dedent() " }
call TQ84_log_indent('plugin on') " {
filetype plugin on
" ------------------
" This command also tries to load $VIMRUNTIME/filetype.vim
"
call TQ84_log_dedent() " }
call TQ84_log_indent('indent on') " {
"    TODO 2015-07-31. Comment next line if alle_kapitel.html takes too long to edit
filetype indent on
"
"    This command also tries to load $VIMRUNTIME/filetype.vim
"
call TQ84_log_dedent() " }
"  }

" }

" { Gui Options

"   Don't source $VIMRUNTIME/menu.vim (I don't want menus)
"   (must be stated before sourcing :syntax on (sy on))
"   TODO: Is this necessary given that «set guioptions-=m»
"   doesn't display a menu at all?
set guioptions-=M

"   No Menubar anyway
set guioptions-=m

"   No toolbar either
set guioptions-=T

"   Console dialogs instead of gui dialogs for simple options
set guioptions+=c

"   No right scrollbar
set guioptions-=r

" }

" { Files to ignore (when using :e or insert mode )
set wildignore+=*.o
set wildignore+=*.obj
set wildignore+=*.exe
set wildignore+=*.dll
" }

" { OS Dependent
if     has('unix') " {

  call TQ84_log('has unix')
  set guifont=Monospace\ 9

" Full screen
  set columns=999 lines=999

" }
elseif has('win32') || has('win64') " {
  call TQ84_log('has win32 || win64')
  autocmd GUIEnter * simalt ~x

" Only working on windows: opens gvim using the entire screen.
  set guifont=Lucida_Console:h8


  " Search recursively and case insensitive for regular expressions (Windows)
  " For example, search in all *.txt files for foo.*bar:
  " :grep "foo.*bar" *.txt
  set grepprg=findstr\ /n\ /s\ /i\ /r\ /c:$*

" }
else " {

" Others systems...
  no no

endif " }
" }

" { Mappings
  " { Mapleader
 
  " It's been said that mapleader should be set before vundle starts
  " loading the plugins.

    let g:mapleader=","

  " }
  " { let n always search forward, N search backwards
  "   http://vi.stackexchange.com/a/2366/985
    nnoremap <expr> n 'Nn'[v:searchforward]
    nnoremap <expr> N 'nN'[v:searchforward]
  " }
  " { Umlaute
    imap <M-'> ä
    imap <M-;> ö
    imap <M-[> ü
    imap <M-"> Ä
    imap <M-:> Ö
    imap <M-{> Ü
    " }
  " }
  " { <leader>ft Font
   nnoremap <leader>ft+    :call Font#ResizeRelative( 1)<CR>
   nnoremap <leader>ft-    :call Font#ResizeRelative(-1)<CR>
   nnoremap <leader>ft=    :call Font#ResizeWithInput()<CR>
  " }
  " { <leader>op Open
   nnoremap <leader>opbl   :call OpenUrl#BlueLetterMitEingabe()<CR>
   nnoremap <leader>opkom  :call OpenUrl#KommentarMitEingabe()<CR>
   nnoremap <leader>oprc   :e $MYVIMRC<CR>
  " }
" }

" { Additional digraphs
:digraph .. 8226
" }

so       $git_work_dir\vim\vimfiles\vimrc
call TQ84_log_dedent()
