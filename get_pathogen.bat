@wget --no-check-certificate "https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim" -O autoload\pathogen.vim

@rem with proxy
@rem wget --no-check-certificate "https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim" -O autoload\pathogen.vim -e --use-proxy=on -e --https_proxy=%HTTP_PROXY%
