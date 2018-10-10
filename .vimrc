scriptencoding utf-8

" vim-plug {{{
call plug#begin('~/vimfiles/plugged')

" Plug 'pocke/iro.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'mattn/vim-filewatcher'
Plug 'haya14busa/vim-asterisk'
Plug 'twitvim/twitvim'
Plug 'tpope/vim-surround'
Plug 'cocopon/vaffle.vim'
Plug 'vim-jp/vital.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-launcher'
Plug 'thinca/vim-quickrun'
Plug 'nixprime/cpsm'
Plug 'fatih/vim-go'
Plug 'tpope/vim-fugitive'
Plug 'koron/dicwin-vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()
" }}}

filetype plugin indent on

" {{{ set settings
set scrolloff=999
set tabstop=2
set shiftwidth=2
set foldmethod=marker
set noequalalways
set list
set listchars=tab:^\ ,trail:-
set lines=56
set columns=271
set visualbell
set nonumber
set grepprg=jvgrep
set undofile
set incsearch
set hlsearch
" set splitright
" set splitbelow
set noshowmatch
set noshowmode
set laststatus=2
set showtabline=2
set fileencodings=utf-8,cp932
" }}} set settings

" {{{ backup, tmp, undo directories settings
set backupdir=$HOME/vimfiles/backup
if !isdirectory($HOME . '/vimfiles/backup')
  call mkdir($HOME . '/vimfiles/backup', 'p')
endif

set directory=$HOME/vimfiles/tmp
if !isdirectory($HOME . '/vimfiles/tmp')
  call mkdir($HOME . '/vimfiles/tmp', 'p')
endif

set undodir=$HOME/vimfiles/undo
if !isdirectory($HOME . '/vimfiles/undo')
  call mkdir($HOME . '/vimfiles/undo', 'p')
endif
" }}}

" {{{ vim-go
let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['go'] }
let g:go_list_type = "quickfix"
let g:Align_xstrlen = 3       " for japanese string
" }}} vim-go

" {{{ lightline
let g:lightline = {
			\ 'colorscheme': 'Tomorrow',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'readonly', 'filename', 'modified' ] ],
			\ },
			\ 'component_function': {
			\   'filename': 'LightlineFilename',
			\ },
			\ }

function! LightlineFilename()
	return &filetype ==# 'vaffle' ? vaffle#buffer#extract_path_from_bufname(expand('%:p')) :
				\ expand('%:~') !=# '' ? expand('%:~') : '[No Name]'
endfunction
" }}} lightline

let g:OmniSharp_server_path = 'C:\OmniSharp\OmniSharp.exe'

let g:quickrun_config = {
			\  "_" : {
			\    "runner" : "job",
			\    "outputter/buffer/split" : ":botright 8sp",
			\    "outputter/buffer/close_on_empty" : 1
			\  },
			\}

noremap <F10> :QuickRun<CR>
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

" 

nnoremap <C-s> :winpos 1300 1075<CR>:set columns=271<CR>:set lines=56<CR>
" nnoremap <C-s> :winpos 1500 400<CR>:set columns=157<CR>:set lines=33<CR>

" CtrlP 
let g:ctrlp_max_files=1000

let g:ctrlp_max_depth=10

let g:ctrlp_clear_cache_on_exit=0

let g:ctrlp_user_command = 'files -A -a -s -d %s'
" let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" 

nnoremap <C-e> :<C-u>CtrlPLauncher<CR>

if (has('mac') || has('unix'))
	set t_Co=256
	set background=light
	let g:solarized_termcolors=256
	colorscheme solarized
endif

augroup QuickFixCmd
	autocmd!
	autocmd QuickFixCmdPost *grep* cwindow
augroup END

augroup fileTypeIndent
	au!
	au BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
	au BufNewFile,BufRead *.jsx setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END

if has('win32')
	if !has('gui_running')
		set t_Co=16
		colorscheme default
	endif
	set encoding=utf-8
endif

" {{{ ChangeCurrentDir
command! -nargs=? -complete=dir -bang CD call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
	if &filetype ==# 'vaffle'
		execute 'lcd ' . vaffle#buffer#extract_path_from_bufname(expand('%:p'))
	else
		if a:directory == ''
			lcd %:p:h
		else
			execute 'lcd' . a:directory
		endif
	endif

	if a:bang == ''
		pwd
	endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>
" }}} ChangeCurrentDir

map *  <Plug>(asterisk-z*)
map g* <Plug>(asterisk-gz*)
map #  <Plug>(asterisk-z#)
map g# <Plug>(asterisk-gz#)

map s  <C-w>

nmap + <Plug>(operator-replace)

nnoremap <Space>ter :terminal ++close<CR>

syntax on
