# .vim

## Windows vs Unix

Since Vim 7.4, all configuration files, even the [vimrc](https://github.com/ReneNyffenegger/.vim/blob/master/vimrc) file go to the directory `%userprofile%\vimfiles` on Windows and
`$HOME/.vim` on Unix.

So, on a Unix system, the files need to be cloned with `git clone <remote url> ~/.vim`, on a Windows system, they need to be cloned with `git clone <remote url> $HOME/vimfiles`.

See Stackoverflow question [Keeping personal vimrc and syntax files etc in source control?](http://vi.stackexchange.com/questions/4027/keeping-personal-vimrc-and-syntax-files-etc-in-source-control)
and the [accepted answer](http://vi.stackexchange.com/a/4030/985).j:w
1G

