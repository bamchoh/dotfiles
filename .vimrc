filetype off
filetype plugin indent off     " required!

if (has('mac') || has('unix'))
  set runtimepath^=~/.vim/bundle/dein.vim/repos/github.com/Shougo/dein.vim
  call dein#begin(expand('~/.vim/bundle/dein.vim'))
else
  set runtimepath^=~/vimfiles/bundle/dein.vim/repos/github.com/Shougo/dein.vim
  call dein#begin(expand('~/vimfiles/bundle/'))
endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neobundle.vim')
call dein#add('Shougo/vimproc')
" call dein#add('VimClojure')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim')
" call dein#add('Shougo/vimshell')
call dein#add('Shougo/neomru.vim')
" call dein#add('Shougo/neocomplcache')
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
" call dein#add('jpalardy/vim-slime')
call dein#add('scrooloose/syntastic')
call dein#add('rking/ag.vim')
call dein#add('vim-scripts/Align')
call dein#add('kana/vim-operator-user')
call dein#add('kana/vim-operator-replace')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('mattn/ctrlp-launcher')
call dein#add('thinca/vim-quickrun')
call dein#add('tpope/vim-fugitive')
call dein#add('scrooloose/nerdtree')
call dein#add('altercation/vim-colors-solarized')
call dein#add('t9md/vim-foldtext')

" Required:
call dein#end()

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" vimproc setting "{{{
if has('mac')
	let g:vimproc_dll_path = $VIM . '/plugins/vimproc/lib/vimproc_mac.so'
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

if (has('mac') || has('unix'))
  colorscheme solarized
  set backupdir=$HOME/.vim/backup
  set directory=$HOME/.vim/tmp
  set undodir=$HOME/.vim/undo
else
  set backupdir=$HOME/vimfiles/backup
  set directory=$HOME/vimfiles/tmp
  set undodir=$HOME/vimfiles/undo
endif

set undofile

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

