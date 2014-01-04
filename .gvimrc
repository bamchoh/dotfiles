set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/vimfiles/bundle/neobundle.vim
	call neobundle#rc(expand('~/vimfiles/bundle/'))
endif

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'rking/ag.vim'
""NeoBundle 'https://bitbucket.org/kovisoft/slimv'

filetype plugin indent on     " required!
filetype indent on
syntax on

scriptencoding cp932

set encoding=cp932
set guifont=Consolas:h12:cSHIFTJIS
"" set guifontwide=MeiryoKe_Gothic:h12:cSHIFTJIS
set ambiwidth=double

set tabstop=2
set shiftwidth=2
set expandtab
set background=dark
colorscheme lucius

