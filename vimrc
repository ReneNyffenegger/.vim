set rtp+=$git_work_dir\vim\vimfiles
set rtp+=$git_work_dir\vim\vimfiles\after

" Log functions {
:runtime lib\tq84_log.vim
call TQ84_log_init()
" }


so       $git_work_dir\vim\vimfiles\vimrc
