" �ʂ̃^�u�̕\���ݒ�����܂�
function! GuiTabLabel()
	" �^�u�ŕ\�����镶����̏����������܂�
	let l:label = ''

	" �^�u�Ɋ܂܂��o�b�t�@(�E�B���h�E)�ɂ��Ă̏����Ƃ��Ă����܂��B
	let l:bufnrlist = tabpagebuflist(v:lnum)

	" �\��������Ƀo�b�t�@����ǉ����܂�
	" �p�X��S���\��������ƒ����̂Ńt�@�C�����������g���܂� �ڂ����� help fnamemodify()
	let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
	" �o�b�t�@�����Ȃ���� No title �Ƃ��Ă����܂��B�����ł̓}���`�o�C�g�������g��Ȃ��ق�������ł�
	let l:label .= l:bufname == '' ? 'No title' : l:bufname

	" �^�u���ɃE�B���h�E����������Ƃ��ɂ͂��̐���ǉ����܂�(�f�t�H���g�ňꉞ����̂�)
	let l:wincount = tabpagewinnr(v:lnum, '$')
	if l:wincount > 1
		let l:label .= '[' . l:wincount . ']'
	endif

	" ���̃^�u�y�[�W�ɕύX�̂���o�b�t�@����Ƃ��ɂ� '[+]' ��ǉ����܂�(�f�t�H���g�ňꉞ����̂�)
	for bufnr in l:bufnrlist
		if getbufvar(bufnr, "&modified")
			let l:label .= '[+]'
			break
		endif
	endfor

	" �\���������Ԃ��܂�
	return l:label
endfunction

" guitablabel �ɏ�̊֐���ݒ肵�܂�
" ���̕\���̑O�� %N �Ƃ����Ƃ���Ń^�u�ԍ���\�������Ă��܂�
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
