filetype off
filetype plugin indent off     " required!

if &compatible
  set nocompatible               " Be iMproved
endif

" dein.vim {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute 'silent !git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = '~/dotfiles/.dein.toml'
  call dein#load_toml(s:toml, {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif


" If you want to install not installed plugins on startup.
silent if dein#check_install()
  silent call dein#install()
endif
" }}}

" vimproc setting "{{{
if has('mac')
  let g:vimproc_dll_path = $VIM . '/plugins/vimproc/lib/vimproc_mac.so'
elseif has('win64')
  let g:vimproc_dll_path = $VIM . '/plugins/vimproc/lib/vimproc_win64.dll'
elseif has('win32')
  let g:vimproc_dll_path = $VIM . '/plugins/vimproc/lib/vimproc_win32.dll'
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

" neosnippet {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" }}}

set tabstop=2
set shiftwidth=2
set nu
set foldmethod=marker
set noequalalways
set list
set listchars=tab:^\ ,trail:-
let g:Align_xstrlen = 3       " for japanese string
set lines=115
set columns=150
winpos 1400 0
set visualbell

" NeoBundleConfiguration {{{

let g:neobundle_default_git_protocol='https'

" }}}

" vimfiler settings {{{
let g:vimfiler_enable_auto_cd = 1
let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_edit_action="vsplit"
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

" CtrlP {{{
let g:ctrlp_max_files=100000

let g:ctrlp_max_depth=10

let g:ctrlp_clear_cache_on_exit=0

let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" }}}

set laststatus=2
set cmdheight=2

if (has('mac') || has('unix'))
	if &term =~ "xterm"
		let &t_Co=256
		let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
		let &t_te = "\<Esc>[?47l\<Esc>8"

		if has("terminfo")
			let &t_Sf = "\<Esc>[3%p1%dm"
			let &t_Sb = "\<Esc>[4%p1%dm"
		else
			let &t_Sf = "\<Esc>[3%dm"
			let &t_Sb = "\<Esc>[4%dm"
		endif
	endif
	colorscheme solarized
	set background=dark
endif

if has('win64') ||  has('win32')
	if !has('gui_running')
		if !empty($CONEMUBUILD)
			set encoding=UTF-8
			set fileencoding=UTF-8
			set termencoding=utf8
			set term=xterm
			set t_Co=256
			let &t_AB="\e[48;5;%dm"
			let &t_AF="\e[38;5;%dm"
		else
			set background=light
			set t_Co=256
			colorscheme default
			let g:lightline = { 'colorscheme': 'solarized' }
		endif
		colorscheme default
		set background=dark
	endif
	scriptencoding cp932
	set encoding=cp932
endif

if !isdirectory($HOME . '/vimfiles/backup')
	call mkdir($HOME . '/vimfiles/backup', 'p')
endif

if !isdirectory($HOME . '/vimfiles/tmp')
	call mkdir($HOME . '/vimfiles/tmp', 'p')
endif

if !isdirectory($HOME . '/vimfiles/undo')
	call mkdir($HOME . '/vimfiles/undo', 'p')
endif

set backupdir=$HOME/vimfiles/backup
set directory=$HOME/vimfiles/tmp
set undodir=$HOME/vimfiles/undo

set undofile

filetype plugin indent on     " required!
syntax on

