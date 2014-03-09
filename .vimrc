set nocompatible
colorscheme solarized
set background=dark
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set nu
set laststatus=2
let g:solarized_termtrans=1

set tags=./tags,TAGS,tags,TAGS

"{{{
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
"}}}

filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
"" NeoBundle 'vim-coffee-script'
"" NeoBundle 'https://bitbucket.org/kovisoft/slimv'

" Others
NeoBundle 'tpope/vim-endwise.git'
NeoBundle 'ruby-matchit'
NeoBundle 'vim-scripts/dbext.vim'

" Complement
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
" NeoBundle 'taichouchou2/vim-rsense'

" Comment
NeoBundle 'tomtom/tcomment_vim'
" NeoBundle 'taichouchou2/surround.vim'

" Supporting Rails
" NeoBundle 'taichouchou2/vim-rails'
NeoBundle 'romanvbabenko/rails.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'rking/ag.vim'
""NeoBundle 'https://bitbucket.org/kovisoft/slimv'
NeoBundle 'ujihisa/unite-rake'
NeoBundle 'basyura/unite-rails'

" reference environment
NeoBundle 'thinca/vim-ref'
" NeoBundle 'taichouchou2/vim-ref-ri'
NeoBundle 'skwp/vim-rspec'
NeoBundle 'rking/ag.vim'

NeoBundle 'vim-scripts/vim-diff'

"-------------------------------------
" syntax highlight
"-------------------------------------
"{{{
" Less syntax
NeoBundle 'groenewege/vim-less'
" Coffee-script syntax
NeoBundle 'kchmck/vim-coffee-script'
"}}}

filetype plugin indent on     " required!
filetype indent on
set background=dark
let g:solarized_termcolors=256
:syntax on
syntax on

" keymap"{{{
" Plugin key-mappings.
imap <C-F>     <Plug>(neocomplcache_snippets_expand)
smap <C-F>     <Plug>(neocomplcache_snippets_expand)
imap <C-U>     <Esc>:Unite snippet<CR>
inoremap <expr><C-g>     neocomplcache#undo_Completion()
au FileType snippet nmap <buffer><Space>e :e #<CR>
" inoremap <expr><C-L>     neocomplcache#complete_common_string()

" imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ?
"       \"\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" snippet
nmap <Space>e :<C-U>NeoComplCacheEditSnippets<CR>
au BufRead,BufNewFile *.snip  set filetype=snippet

let g:neocomplcache_enable_auto_select = 0
inoremap <silent><expr><TAB>  pumvisible() ? "\<C-N>" : "\<TAB>"
inoremap <silent><expr><S-TAB> pumvisible() ? "\<C-P>" : "\<S-TAB>"
inoremap <silent><expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplcache#close_popup()
" inoremap <expr><C-e>  neocomplcache#cancel_popup()
" inoremap <silent><CR>  <C-R>=neocomplcache#smart_close_popup()<CR><CR>
inoremap <silent><CR>  <CR><C-R>=neocomplcache#smart_close_popup()<CR>
" inoremap <silent><expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" inoremap <silent><expr><CR>   neocomplcache#smart_close_popup()."\<C-h>"

set lcs=tab:>.,trail:_,extends:\
set list
highlight SpecialKey cterm=NONE ctermfg=7 guifg=7
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/

"--------------------------------------
" vim-rsense
"--------------------------------------
"{{{
" Rsense
let g:rsenseUseOmniFunc = 1
let g:rsenseHome = expand('~/.vim/ref/rsense-0.3')

function! SetUpRubySetting()
  setlocal completefunc=RSenseCompleteFunction
  nmap <buffer>tj :RSenseJumpToDefinition<CR>
  nmap <buffer>tk :RSenseWhereIs<CR>
  nmap <buffer>td :RSenseTypeHelp<CR>
endfunction
autocmd FileType ruby,eruby,ruby.rspec call SetUpRubySetting()

" setting ruby
"if !exists('g:neocomplcache_omni_functions')
"  let g:neocomplcache_omni_functions = {}
"endif
"let g:neocomplcache_omni_functions.ruby = 'RSenseCompleteFunction'
"
"" Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"  let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[-. *\t]\.\w*\|\h\w*::'
"}}}
"
map <C-g> :Gtags
map <C-h> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

