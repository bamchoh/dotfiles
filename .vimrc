filetype off
filetype plugin indent off     " required!

if &compatible
	set nocompatible
end

set runtimepath^=~/vimfiles/bundle/dein.vim

call dein#begin(expand('~/vimfiles/bundle/'))

" originalrepos on github
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

call dein#end()

" vimproc setting "{{{
if has('mac')
	let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_mac.so'
elseif has('win64')
	let g:vimproc_dll_path = $HOME . '/vimfiles/vimproc_win64.dll'
elseif has('win32')
	let g:vimproc_dll_path = $VIM . '/plugins/vimproc/autoload/vimproc_win32.dll'
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
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" " }}}

set tabstop=2
set shiftwidth=2
set nu
set foldmethod=marker
set noequalalways
set list
set listchars=tab:^\ ,trail:-
let g:Align_xstrlen = 3       " for japanese string
set lines=50
set columns=80
winpos 0 0

map R <Plug>(operator-replace)
nnoremap <C-e> :<C-u>CtrlPLauncher<CR>

set backupdir=$HOME/vimfiles/backup
set directory=$HOME/vimfiles/tmp
set undodir=$HOME/vimfiles/undo
set undofile

" NeoBundleConfiguration {{{

let g:neobundle_default_git_protocol='https'

" }}}

" vimfiler settings {{{
let g:vimfiler_enable_auto_cd = 1
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_edit_action="vsplit"
let g:vimfiler_directory_display_top=1
let g:vimfiler_safe_mode_by_default=0
" }}}

" QuickRun Configuration {{{

if has('win32') || has('win64')
	function! s:hook_quickrun_windows()
		let hook = {
					\ "name" : "nossl",
					\ "kind" : "hook",
					\}

		function! hook.init(session)
			let config = a:session.config
			let runner = config.runner
			let enable = get(config, 'hook/nossl/enable', 1)
			let self.config.enable = enable && &ssl && runner ==# 'system'
		endfunction

		function! hook.on_module_loaded(...)
			if &ssl
				let self.save_ssl = &ssl
				set nossl
			endif
		endfunction

		function! hook.sweep(...)
			if has_key(self, 'save_ssl')
				let &ssl = self.save_ssl
				unlet self.save_ssl
			endif
		endfunction

		call quickrun#module#register(hook)
	endfunction

	call s:hook_quickrun_windows()
endif

let g:quickrun_config = {
			\  "_" : {
			\    "runner" : "vimproc",
			\    "runner/vimproc/updatetime" : 60,
			\    "outputter/buffer/split" : ":botright 8sp",
			\    "outputter/buffer/close_on_empty" : 1
			\  },
			\}

noremap <F10> :QuickRun<CR>
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

" }}}

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

" Unite Source Settings {{{
let s:unite_source = {
			\ 'name': 'keycode',
			\ }

function! s:unite_source.gather_candidates(args, context)
	return map(['a', 'b', 'c'], '{
				\ "word" : v:val,
				\ "source__keycode_name" : v:val,
				\ }')
endfunction
call unite#define_source(s:unite_source)
unlet s:unite_source
" }}}



filetype plugin indent on     " required!
syntax on

