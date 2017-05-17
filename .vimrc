filetype off
filetype plugin indent off     " required!

set tabstop=2
set shiftwidth=2
set foldmethod=marker
set noequalalways
set list
set listchars=tab:^\ ,trail:-
set lines=60
set columns=150
set visualbell
set langmenu=none
set nonumber
set norelativenumber
set grepprg=jvgrep
set backupdir=$HOME/vimfiles/backup
set directory=$HOME/vimfiles/tmp
set undodir=$HOME/vimfiles/undo
set undofile

" dein.vim 
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
" 

" vimproc setting 
if has('mac')
  let g:vimproc#dll_path = $VIM . '/plugins/vimproc/lib/vimproc_mac.so'
elseif has('win64')
  let g:vimproc#dll_path = $VIM . '/plugins/vimproc/lib/vimproc_win64.dll'
elseif has('win32')
  let g:vimproc#dll_path = $VIM . '/plugins/vimproc/lib/vimproc_win32.dll'
endif
" 

" neocomplete setting 
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
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" " 

" neosnippet 
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" 

let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['go'] }
let g:go_list_type = "quickfix"
let g:Align_xstrlen = 3       " for japanese string
" NeoBundleConfiguration 

let g:neobundle_default_git_protocol='https'

" 

" QuickRun Configuration 

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

" 

nnoremap <C-s> :winpos 1500 0<CR>:set columns=200<CR>:set lines=80<CR>
" nnoremap <C-s> :winpos 1500 400<CR>:set columns=157<CR>:set lines=33<CR>

" CtrlP 
let g:ctrlp_max_files=1000

let g:ctrlp_max_depth=10

let g:ctrlp_clear_cache_on_exit=0

" let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" 

nnoremap <C-e> :<C-u>CtrlPLauncher<CR>

if (has('mac') || has('unix'))
  colorscheme solarized
  set background=dark
endif

augroup QuickFixCmd
	autocmd!
	autocmd QuickFixCmdPost *grep* cwindow
augroup END

augroup fileTypeIndent
	au!
	au BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END

if has('win64') ||  has('win32')
	if !has('gui_running')
		if !empty($CONEMUBUILD)
			set encoding=UTF-8
			set fileencoding=UTF-8
			" echom "Running in conemu"
			set termencoding=utf8
			set term=xterm
			set t_Co=256
			let &t_AB="\e[48;5;%dm"
			let &t_AF="\e[38;5;%dm"
			" termcap codes for cursor shape changes on entry and exit to
			" /from insert mode
			" doesn't work
			"let &t_ti="\e[1 q"
			"let &t_SI="\e[5 q"
			"let &t_EI="\e[1 q"
			"let &t_te="\e[0 q"
		else
			set background=light
			set t_Co=256
			colorscheme default
			let g:lightline = { 'colorscheme': 'solarized' }
		endif
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

command! -nargs=? -complete=dir -bang CD call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
	if a:directory == ''
		lcd %:p:h
	else
		execute 'lcd' . a:directory
	endif

	if a:bang == ''
		pwd
	endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

" 個別のタブの表示設定をします
function! GuiTabLabel()
  " タブで表示する文字列の初期化をします
  let l:label = ''

  " タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
  let l:bufnrlist = tabpagebuflist(v:lnum)

  " 表示文字列にバッファ名を追加します
  " パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  " バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
  let l:label .= l:bufname == '' ? 'No title' : l:bufname

  " タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
  let l:wincount = tabpagewinnr(v:lnum, '$')
  if l:wincount > 1
    let l:label .= '[' . l:wincount . ']'
  endif

  " このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
  for bufnr in l:bufnrlist
    if getbufvar(bufnr, "&modified")
      let l:label .= '[+]'
      break
    endif
  endfor

  " 表示文字列を返します
  return l:label
endfunction

" guitablabel に上の関数を設定します
" その表示の前に %N というところでタブ番号を表示させています
set guitablabel=%N:\ %{GuiTabLabel()}

filetype plugin indent on     " required!
syntax on

