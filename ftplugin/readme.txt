The files in this directory are usually(?) loaded/executed
through the function LoadFTPlugin() which is defined in
$VIMRUNTIME/ftplugin.vim

More specifically, LoadFTPlugin() has this line:
	exe 'runtime! ftplugin/' . name . '.vim ftplugin/' . name . '_*.vim ftplugin/' . name . '/*.vim'

LoadFTPlugin itself is triggered by a
  au FileType * call s:LoadFTPlugin()
(found in the same file)

