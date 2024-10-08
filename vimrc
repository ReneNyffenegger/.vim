"   2016-12-27: Adding nocompatible because starting
"   vim with -u ~/.vim/vimrc seems to start vim
"   in compatible mode... (See comment for 'set nocompatible' below)
set nocompatible
set encoding=utf8       " {
"   At the very start, so that the various mappings involving
"   the Meta key (Alt) work, at least on windows, that is.
"   }


" Log functions {
" Create the log functions before they're used the
" first time. See TQ84_log_indent below.
runtime lib/tq84_log.vim
call TQ84_log_init()
" }

call TQ84_log_indent(expand("<sfile>") . ', line ' . expand("<slnum>") . ": After calling TQ84_log_init()")

call tq84#option#log()
let s:options_start = tq84#option#values()

if exists('$git_work_dir') " {
    if isdirectory($git_work_dir)
       call TQ84_log('$git_work_dir exists, adding to &rtp')
       set rtp+=$git_work_dir/vim/vimfiles
       set rtp+=$git_work_dir/vim/vimfiles/after
    else
       call TQ84_log('$git_work_dir [' . $git_work_dir . '] is not a directory')
    endif
" }
else " {
   call TQ84_log('$git_work_dir does not exists, not adding to &rtp')
endif " }

call tq84#option#rmDupRTP()

" { set nocompatible
"
"   2016-11-20 Since compatible is set anyway if a vimrc file is found,
"   it does not need to be explicitely be set.
"
"   This is a special kind of option, because when it's set or
"   reset, other options are changes as a side effect.
"  (See for example http://stackoverflow.com/questions/23012391)
"
"   Note, the option is set anyway when a (g)vimrc file is found
"
" set nocompatible
" call TQ84_log('compatible after unsetting it:  ' . &compatible)
" }

" { Bare minimum settings

set hidden
set lazyredraw      "   Don't update display while executing macros.
set nowrap
set linebreak       "   Only used when a text is «wrapped» (set wrap): prevents words from being broken in the middle.
set bs=2            "   allow backspacing over everything in insert mode

" }

" { Gui Options

call TQ84_log('line ' . expand('<slnum>') . ': guioptions = ' . &guioptions)

"   Don't source $VIMRUNTIME/menu.vim (I don't want menus)
"   (must be stated before sourcing :syntax on (sy on))
"   TODO: Is this necessary given that «set guioptions-=m»
"   doesn't display a menu at all?
set guioptions+=M

"   No Menubar anyway
set guioptions-=m

"   No toolbar either
set guioptions-=T

"   Console dialogs instead of gui dialogs for simple options
set guioptions+=c

"   No right scrollbar
set guioptions-=r

call TQ84_log('line ' . expand('<slnum>') . ': guioptions = ' . &guioptions)

" }

" { Filetype related
call TQ84_log_indent('line ' . expand('<slnum>') . ': filetype on') " {
" The 'filetype on' command loads  $VIMRUNTIME/filetype.vim, which
" defines autocommands for the BufNewFile and BufRead
" events.
" Typically, $VIMRUNTIME/filetype.vim contains autocommand
" definitions such as:
"
"   au BufNewFile,BufRead *.java,*.jav		setf java
"
"  2020-10-10: commented out:
"     filetype on
"  because try to manually control which suffixes are related to what filetype.
" (However, $VIMRUNTIME/filetype.vim is also executed by the command 'filetype plugin on`,
"  below)
call TQ84_log_dedent() " }

" 2020-10-10: definition of filetypes
au BufNewFile,BufRead *.pks,*pkb,*.tys,*.tyb,*.plsql setf plsql

call TQ84_log_indent('line ' . expand('<slnum>') . ': plugin on') " {
" filetype plug on also executes $VIMRUNTIME/filetype.vim …
filetype plugin on
call TQ84_log_dedent() " }
call TQ84_log_indent('line ' . expand('<slnum>') . ': indent on') " {
"    2015-07-31. Comment next line if alle_kapitel.html takes too long to edit
"    2019-06-07: Apparently »filetype indent on« switches to »indentexpr«
"                indenting. So, comment it:
"    filetype indent on
"
"    This command also tries to load $VIMRUNTIME/filetype.vim
"
call TQ84_log_dedent() " }
"  }

" { Pathogen
runtime autoload/pathogen.vim
if exists('*pathogen#infect')
   call TQ84_log_indent('pathogen#infect')
   execute pathogen#infect()
   call TQ84_log_dedent()
else
   call TQ84_log('pathogen#infect not found')
endif
" }

" { Colors / Syntax highlightening
"         ----------------------------------
"   «syntax on» seems to want to read $VIMRUNTIME/syntax/syntax.vim
"
"   The syntax commands are implemented by sourcing a file:
"      :syntax enable  $VIMRUNTIME/syntax/syntax.vim
"      :syntax on      $VIMRUNTIME/syntax/syntax.vim
"      :syntax manual  $VIMRUNTIME/syntax/manual.vim
"      :syntax off     $VIMRUNTIME/syntax/nosyntax.vim

call TQ84_log('line ' . expand('<slnum>') . ': Colors / Syntax highlightening')

call TQ84_log_indent('syntax enable')
syntax enable  " Not exactly equivalent to «syntax on». see :help syntax (under 1. Quick start)
call TQ84_log_dedent()

call TQ84_log_indent('line ' . expand('<slnum>') . ': colorscheme rene')
" colorscheme rene
call TQ84_log_dedent()

" }

" { Backup files

if exists('g:TQ84_CRYPT') && g:TQ84_CRYPT
  call TQ84_log('line ' . expand('<slnum>') . ': TQ84_CRYPT is enabled')
  set nobackup
  set nowritebackup
" no swapfile possibly already set with «-n»
  set noswapfile

" 2016-01-26: http://vi.stackexchange.com/questions/6177/
  set history=0
  set nomodeline " why ?

" Note: somehow, when setting noshelltemp, system() on Windows
"       starts to report errors in a Message Box.
  set noshelltemp

  set noundofile
  set secure
  set viminfo=""
else
  call TQ84_log('line ' . expand('<slnum>') . ': TQ84_CRYPT not enabled')

  set nobackup
  set writebackup
endif

"  set backupdir=c:\temp\vim

"  }

" { Status line

set statusline=\ 
set statusline+=%f              " relative filename
set statusline+=\ %y            " filetype
set statusline+=\ ic:%{&ic}     " show ignore case flag
set statusline+=\ pt:%{&paste}  " show ignore case flag
set statusline+=\ ve:%{&ve}     " virtual edit
set statusline+=\ ff:%{&ff}     " file format
set statusline+=\ %m            " file modification flag
set statusline+=\ %=            " Jump to right portion of status line
set statusline+=\ c:%c          " column (Counts bytes, not characters)
set statusline+=\ v:%v          " virtual column
set statusline+=\ %l            " line
set statusline+=/%L             " total number of lines
set statusline+=\               " final space

call TQ84_log('statusline=' . &statusline)

"   Always show status line
set laststatus=2

" }

" { Other settings

" { Editing

set shiftwidth=2
set tabstop=2
set autoindent

set expandtab            " use spaces instead of tabulators
set smarttab

if has('gui_running') " {
   set guicursor=a:blinkon0 " no blinking cursor  (a = all modes)
" }
else " {
 " { Set Shape of cursor (http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes)

 " Todo: why is the reaction time so slow?
 "
 " Todo: Do I still need them
 "
   " 2018-02-13: commented, see https://vi.stackexchange.com/questions/15192
   "
   "  " Insert mode: I-Beam
   "    let &t_SI = "\<Esc>[6 q"
   "  " Replace mode: underline
   "    let &t_SR = "\<Esc>[4 q"
   "  " Normal mode: block
   "    let &t_EI = "\<Esc>[2 q"

  " }
endif " }

set foldmarker=\ {,\ }

" }

" keep 999 lines of command line history
set history=999

" 2016-11-20 wildchar=9 seems to be the default with nocompatible
" set wildchar=9
"set wildmode=list,longest

" No fancy visual bell
set visualbell t_vb=""

set relativenumber
set number

set suffixes=.bak,~,.o,.info,.swp,.obj

" }

" { Languages
" Use english messages
language message en_US.UTF-8
" }

" { OS Dependent
if     has('unix') " {

  call TQ84_log('line ' . expand('<slnum>') . ': has unix')
" 2023-10-19 Debian on WSL does not seem to have Monospace ubiquitously
  set guifont=Monospace\ 9
  set guifont=Liberation\ Mono\ 9

  if has('gui_running')
  "  2016-12-27: Go full screen only if running in gui.
  "  See also http://stackoverflow.com/questions/4229658/why-some-people-use-if-hasgui-running-in-a-gvimrc
     call TQ84_log('has gui_running')
  "  Full screen
     set columns=999 lines=999
  else
     call TQ84_log('does not have gui_running')
  endif

" { Files to ignore (when using :e or insert mode )

  set wildignore+=*.o

" }

" }
elseif has('win32') || has('win64') " {
  call TQ84_log('line ' . expand('<slnum>') . ': has win32 || win64')

" Only working on windows: opens gvim using the entire screen.
  autocmd GUIEnter * simalt ~x

  set guifont=Lucida\ Console:h8:cDEFAULT


  " Search recursively and case insensitive for regular expressions (Windows)
  " For example, search in all *.txt files for foo.*bar:
  " :grep "foo.*bar" *.txt
  set grepprg=findstr\ /n\ /s\ /i\ /r\ /c:$*

" { Files to ignore (when using :e or insert mode )

  set wildignore+=*.obj
  set wildignore+=*.exe
  set wildignore+=*.dll

" }

" }
else " {

" Others systems...
  no no

endif " }
" }

" { Mappings
call TQ84_log_indent('line ' . expand('<slnum>') . ': Mappings')
  " { Mapleader

  " It's been said that mapleader should be set before vundle starts
  " loading the plugins.
  "
  " See also
  " https://github.com/ReneNyffenegger/about-vim/blob/master/vimscript/variables/g_mapleader.vim

    let g:mapleader=","

  " }
  " { let n always search forward, N search backwards
  "   http://vi.stackexchange.com/a/2366/985
    nnoremap <expr> n 'Nn'[v:searchforward]
    nnoremap <expr> N 'nN'[v:searchforward]
  " }
  " { Umlaute
    inoremap <M-'> ä
    inoremap <M-;> ö
    inoremap <M-[> ü
    inoremap <M-"> Ä
    inoremap <M-:> Ö
    inoremap <M-{> Ü

    cnoremap <M-'> ä
    cnoremap <M-;> ö
    cnoremap <M-[> ü
    cnoremap <M-"> Ä
    cnoremap <M-:> Ö
    cnoremap <M-{> Ü
  " }
  " { Special characters

  " http://vi.stackexchange.com/questions/4284/how-can-i-map-alt-or-alt
    inoremap ¬ «
    inoremap ® »
"   inoremap <M-<> «
"   inoremap <M->> »
  " }
  " { <leader>ft Font
   nnoremap <leader>ft+    :call Font#ResizeRelative( 1)<CR>
   nnoremap <leader>ft-    :call Font#ResizeRelative(-1)<CR>
   nnoremap <leader>ft=    :call Font#ResizeWithInput()<CR>
   nnoremap <leader>fth    :call Font#Hebrew()<CR>
   nnoremap <leader>ftr    :call Font#Reset()<CR>
  " }
  " { <leader>op Open
   nnoremap <leader>op      <Nop>
   nnoremap <leader>op.     :execute 'e ' . expand('%:p:h')<CR>
   nnoremap <leader>opbusc  :call tq84#buf#openScratch('scratch-buf')<CR>
   nnoremap <leader>opfile  :call tq84#OpenDocument(expand('<cWORD>'))<CR>
   nnoremap <leader>opkom   :call OpenUrl#KommentarMitEingabe()<CR>
   nnoremap <leader>opalk   :execute 'e ' . $github_root . 'Bibelkommentare/Text'<CR>
   execute 'nnoremap <leader>opkon   :e ' . $github_root . 'notes/notes/biblisches/Eigene-Uebersetzung/Konkordanz/'
 " { Internet
   nnoremap <leader>opdict  :call OpenUrl#dict_leo_org(input("Search Term: "))<CR>

"  ---------------------------------------------------------------------
"  2019-01-21: Apparently, `gx` provides the same functionality:
"  nnoremap <leader>opurl   :call OpenUrl#Go(expand('<cWORD>'))<CR>
   nnoremap <leader>opurl   :echoerr 'Use gx'<CR>
"  ---------------------------------------------------------------------

   nnoremap <leader>opgo    :call OpenUrl#GoogleSearch(input('? '))<CR>
 " }
 " { gt
   nnoremap ,gtbk           :call tq84#bibelkommentare#gotoVerseFromContext()<CR>
 " }
 " { Bible Translations 
   nnoremap <leader>oplu15  :call OpenUrl#BibelOnlineMitEingabe('luther_1545_letzte_hand')<CR>
   nnoremap <leader>oplu12  :call OpenUrl#BibelOnlineMitEingabe('luther_1912')<CR>
   nnoremap <leader>oplu17  :call tq84#websites#bibleserver#openLuther2017(Bibel#EingabeBuchKapitelVers())<CR>
   nnoremap <leader>opintl  :call OpenUrl#BibelOnlineMitEingabe('interlinear')<CR>

"  Neue Evangelistische Übersetzung:
   nnoremap <leader>opneu   :call OpenUrl#NeueEVUebMitEingabe()<CR>
   nnoremap <leader>opsch51 :call OpenUrl#BibelOnlineMitEingabe('schlachter_1951')<CR>
   nnoremap <leader>opelb05 :call OpenUrl#BibelOnlineMitEingabe('elberfelder_1905')<CR>
   nnoremap <leader>opntwe  :call OpenUrl#NT_W_Einert_MitEingabe()<CR>
   nnoremap <leader>opmenge :call OpenUrl#MengeUebersetzungMitEingabe()<CR>
   nnoremap <leader>op4     :call misc#OpenScriptureForAll()<CR>
   nnoremap ,opinlh         :call tq84#websites#biblehub#openInterlinearVerse(Bibel#EingabeBuchKapitelVers())<CR>
   nnoremap ,opbhcom        :call tq84#websites#biblehub#openCommentaries(Bibel#EingabeBuchKapitelVers())<CR>
   " { Locally available
   nnoremap <leader>opeue   :call tq84#buf#openFile(Bibel#PfadTextDatei('eue'))<CR>
   nnoremap <leader>opjantz :call tq84#buf#openFile(Bibel#PfadTextDatei('jantz'))<CR>
   nnoremap <leader>opkjv   :call tq84#buf#openFile(Bibel#PfadTextDatei('kjv'))<CR>
   nnoremap <leader>opelb05 :call tq84#buf#openFile(Bibel#PfadTextDatei('elb1905'))<CR>
   nnoremap <leader>opsch2k :call tq84#buf#openFile(Bibel#PfadTextDatei('sch2k'))<CR>
   " }
 " }
 " { Blue letter bible related
   nnoremap <leader>opstr   :call OpenUrl#StrongsWithInput()<CR>
   nnoremap <leader>opbl    :call OpenUrl#BlueLetterWithInput()<CR>
 " }

"  Open VIM related files {
   nnoremap <leader>oprc    :e $MYVIMRC<CR>
   nnoremap <leader>opviro  :exe 'e ' . fnamemodify($MYVIMRC   , ':h')<CR>
   nnoremap <leader>opviru  :exe 'e ' . fnamemodify($VIMRUNTIME, ':h')<CR>
   nnoremap <leader>opvitq  :exe 'e ' . fnamemodify($MYVIMRC   , ':h') . '/autoload/tq84'<CR>
"  }
"  { github related directories / files
   nnoremap <leader>opgiab   :exe 'e '.$github_top_root.'about'<CR>
   nnoremap <leader>opgili   :exe 'e '.$github_top_root.'lib'<CR>
   nnoremap <leader>opgiro   :exe 'e '.$github_root<CR>
   "  Open Perl related files {
   nnoremap <leader>opplmo   :exe 'e '.$github_root.'/PerlModules/'<CR>
   "  }
"  }
   " Open a file of which only a part of the file name is known:
   nnoremap <leader>ope8   :e *
  " }
  " { Function keys

" F2: { Ignoring case,  highlighting
nnoremap   <F2> :setlocal ic!<CR>
nnoremap <S-F2> :set hlsearch!<CR>
nnoremap <M-F2> :call tq84#option#toggleColorcolumn(col('.'))<CR>
nnoremap <C-F2> :call tq84#toggle_highlight_word_under_cursor()<CR>
" }
" F3: Complete Filename / path / filename only to clipboard {
nnoremap   <F3> :let @+=expand("%:p")<CR>
nnoremap <S-F3> :let @+=expand("%:p:h")<CR>
nnoremap <M-F3> :let @+=expand("%:t")<CR>
" }
" F4: Yanking {
" copy WORD under cursor to clipboard
nnoremap   <F4> "+yiW

" copy visual selection to clipboard
vnoremap   <F4> "+y

" copy current line to Clipboard
nnoremap <S-F4> "+yy
" }
" F5: {
nnoremap   <F5> :set list!<CR>
nnoremap <S-F5> :set foldmethod=marker foldmarker={,}<CR>

"  Toggle cursor position cross hair:
nnoremap <M-F5> :set cursorline! cursorcolumn!<CR>

nnoremap <C-F5> :call tq84#buf#set_ff_unix_rm_trailing_space()<CR>
" }
" F6: {
nnoremap   <F6> :only<CR>

" Switch from virtual edit back and forth
nnoremap <S-F6> :if &virtualedit == 'all' \| set virtualedit= \| else \| set virtualedit=all \| endif<CR>
" }
" F12 {
  set pastetoggle=<F12>
" }
  " }
  " { Gui
nnoremap <leader>h :call GUI#ChangeMonitor(   0, 0)<CR>
nnoremap <leader>l :call GUI#ChangeMonitor(2000, 0)<CR>
nnoremap <leader>gj :call GUI#Minimize()<CR>
nnoremap <leader>gm :call GUI#Maximize()<CR>
nnoremap <leader>gn :call GUI#NormalSize()<CR>
  " }
  " { cd
" 2022-07-24 nnoremap ,cdnot :cd $github_root/notes/notes<CR>
nnoremap              ,cdnot :cd $notes_dir/notes<CR>
nnoremap ,cdhyd :cd $github_root/Hydroplattentheorie/Präsentation<CR>
" cd to directory of current buffer
nnoremap ,cd.   :execute 'cd ' . expand('%:p:h')<CR>
  " }
  " { shell
nnoremap ,shkomm :echo (system('komm'))<CR>
nnoremap ,shnots :echo (system('nots'))<CR>
  " }
  " { Misc
  "   Map from ^ (6) to $ (4)
nnoremap ,v64 ^v$h
   "  Go to normal mode more easily. {
inoremap jj <Esc>
inoremap jw <Esc>:w<CR>
" Convoluted sequence of commands to chmod 755 current file.
" Without first writing it and reading it after chmod'ing the file,
" a W16 would be thrown.
nnoremap <leader>755 :w \| execute 'silent! !chmod 755 %' \| e! <CR>
   " }
" No more «Entering Ex mode. Type "visual" to go to Normal mode.» {
" map Q <Nop> would do that, but we can just hijack this command
" for something more useful:
map Q gq
" }
nnoremap <leader>sw    :call tq84#SwitchBodyAndSpec()<CR>
nnoremap <leader>burvw :call Buffer#ReverseWordUnderCursor()<CR>
inoremap <leader>indt  =strftime("%Y-%m-%d")<CR>
nnoremap <leader>indt  :execute "normal i" . strftime("%Y-%m-%d")<CR>
  " { helpers for bible study
nnoremap <leader>dv    :call Bibel#ZeigeVerseMitEingabe('eue')<CR>
nnoremap <leader>cpbv  :let @+=Bibel#VersText(Bibel#EingabeBuchKapitelVers(), 'eue')<CR>
inoremap <leader>inbh  =tq84#bibelkommentare#htmlVerseWithLink(Bibel#EingabeBuchKapitelVers())<CR>
inoremap <leader>inbv  =Bibel#VersText(Bibel#EingabeBuchKapitelVers(), 'eue')<CR>
inoremap <leader>inbl  =tq84#bibelkommentare#htmlLinkToVerse(Bibel#EingabeBuchKapitelVers())<CR>
inoremap <leader>inbp  =tq84#notes#bibleVerse()<CR>
vnoremap ,bl2tx        :call tq84#blueletterbible#copied2germanText()<CR>
  " }
  " git {
  " sa  http://vim.wikia.com/wiki/Version_Control_for_Vimfiles
nnoremap <leader>rci  :call tq84#git#ci()<CR>
nnoremap <leader>rst  :call tq84#git#st()<CR>
nnoremap <leader>rup  :call tq84#git#up()<CR>
nnoremap <leader>radd :call tq84#git#add()<CR>

  " }
  " }
  " { Insert mode
  " help ins-special-special
inoremap <C-b> <S-Left>
  " }
  " { Command line mode
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap  e tq84#cmdline#cutPathTail()<CR>
" }
call TQ84_log_dedent()
" }

" { Abbreviations
iabbr aeg Ägypten
" }

" { Additional digraphs
:digraph se  167 " § Section Sign (instead of SE)
:digraph oo 8226 " • Bullet point
:digraph .. 8230 " … (&hellip;)
:digraph -- 9776 " ☰
:digraph ms 8344 " ₘ m subscript (0x2098)
:digraph ns 8345 " ₙ n subscript (0x2099)
" }

" { special hosts / local vimrc

" if hostname() == 'OKFMGMT022'
"   so X:\commands\okfmgmt022.vim
" elseif hostname() == 'NCHA25509404'
"   " do nothing
" else
if exists('$git_work_dir')
   call TQ84_log_indent('line ' . expand('<slnum>') . ': $git_work_dir exists, it is ' . $git_work_dir)
  if isdirectory($git_work_dir)
     call TQ84_log_indent('line ' . expand('<slnum>') . ': going to source $git_work_dir/vim/vimfiles/vimrc')
     so $git_work_dir/vim/vimfiles/vimrc
     call TQ84_log_dedent()
  else
     call TQ84_log($git_work_dir . ' is not a directory')
  endif
else
  call TQ84_log('$git_work_dir does not exist')
endif

" }

" { Autocommands
  autocmd BufNewFile * set ff=unix

  autocmd BufNewFile *.pl :call tq84#ft#perl#BufNewFile()
  " { Autocommands for special files
    autocmd! BufReadPost $github_root/Bibelkommentare/Text so $github_root/Bibelkommentare/mappings.vim
    autocmd! BufReadPost **/about/Unicode/Codepoints/selection.txt setl colorcolumn=7,10,14,22,25
    autocmd! BufReadPost **/github/Geschichte-der-Wissenschaft/Ablauf.pl nnoremap <buffer> ! :execute "echo(tq84#SystemInDir(expand('%:p:h'), 'perl -I ~/github/lib/perl-GraphViz-Graph/lib Ablauf.pl && op Ablauf.pdf'))"<CR>
    autocmd! BufReadPost **/.config/openbox/rc.xml nnoremap <buffer> ! :silent !openbox --reconfigure<CR>
  " }
" }

call tq84#option#diff(s:options_start, tq84#option#values())

if has('fname_case') " {
   call TQ84_log('has fname_case')
else
   call TQ84_log('does not have fname_case')
endif " }

" runtime lib/switchLeftAltCtrl.vim

call TQ84_log_dedent()
