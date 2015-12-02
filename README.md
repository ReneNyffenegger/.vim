# .vim

## Windows vs Unix

Since Vim 7.4, all configuration files, even the
[vimrc](https://github.com/ReneNyffenegger/.vim/blob/master/vimrc) file go to
the directory <del>`%userprofile%\vimfiles`</del> `%HOMEDRIVE%\vimfiles`
on Windows and `$HOME/.vim` on Unix.

So, on a Unix system, the files need to be cloned with `git clone <remote url> ~/.vim`, on a Windows system, they need to be cloned with `git clone <remote url> $HOME/vimfiles`.

See Stackoverflow question [Keeping personal vimrc and syntax files etc in source control?](http://vi.stackexchange.com/questions/4027/keeping-personal-vimrc-and-syntax-files-etc-in-source-control)
and the [accepted answer](http://vi.stackexchange.com/a/4030/985).

## pathogen

Get [pathogen](https://github.com/tpope/vim-pathogen) with `get_pathogen.bat`.

## submodules

Initializing submodules (probably necessary only once)

    git submodule init

Updating submodules

    git submodule update

The following submodules were added:

    git submodule add https://github.com/godlygeek/tabular bundle/tabular
    
