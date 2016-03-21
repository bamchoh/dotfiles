filetype off
filetype plugin indent off     " required!

set runtimepath+=~/vimfiles/bundle/neobundle.vim

call neobundle#begin(expand('~/vimfiles/bundle/'))

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
" NeoBundle 'VimClojure'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
" NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neomru.vim'
" NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'rking/ag.vim'
NeoBundle 'vim-scripts/Align'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'mattn/ctrlp-launcher'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 't9md/vim-foldtext'

call neobundle#end()

NeoBundleCheck

" vimproc setting "{{{
if has('mac')
	let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_mac.so'
elseif has('win64')
	let g:vimproc_dll_path = $HOME . '/vimfiles/bundle/vimproc/autoload/vimproc_win64.dll'
elseif has('win32')
	let g:vimproc_dll_path = $HOME . '/vimfiles/bundle/vimproc/autoload/vimproc_win32.dll'
endif
" }}}

" neocomplete setting "{{{
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>  neocomplete#undo_completion()
inoremap <expr><C-l>  neocomplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
" <TAG>: completion
inoremap <expr><TAB>    pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup."\<C-h>"
" " }}}


set tabstop=2
set shiftwidth=2
set expandtab
set nu
set foldmethod=marker
set noequalalways

let g:Align_xstrlen = 3       " for japanese string

map R <Plug>(operator-replace)
nnoremap <C-e> :<C-u>CtrlPLauncher<CR>

let g:quickrun_config = {
			\   "_" : {
			\    "runner" : "vimproc",
			\    "runner/vimproc/updatetime" : 60,
			\    "outputter/buffer/split" : ":botright 8sp",
			\    "outputter/buffer/close_on_empty" : 1,
			\   },
			\ }

set backupdir=$HOME/vimfiles/backup
set directory=$HOME/vimfiles/tmp
set undodir=$HOME/vimfiles/undo
set undofile

if (has('mac') || has('unix'))
	source ~/vimfiles/vimrc
endif

if has('win64') ||  has('win32')
	scriptencoding cp932
	set encoding=cp932
	if !has('gui_running')
    " set shell=$HOME/apps/nyagos/nyagos.exe
		" set shellcmdflag=
		" set shellquote=\"
		" set shellxquote=
	endif
endif

filetype plugin indent on     " required!
syntax on

