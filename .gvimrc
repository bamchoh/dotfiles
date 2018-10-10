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

let g:DrChipTopLvlMenu = ""   " remove 'DrChip' menu
set guifont=Cica:h12:cSHIFTJIS
set ambiwidth=double
set guioptions-=m
set guioptions-=T
set guioptions-=e
set enc=utf-8
set rop=type:directx,geom:1,renmode:4
source ~/vimfiles/vimrc
