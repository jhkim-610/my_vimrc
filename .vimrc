set shell=/bin/bash

" 1) vim-pathogen
" mkdir -p ~/.vim/autoload ~/.vim/bundle && \
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

" 2) highlight searched patterns
set hlsearch

" 3) line number
set nu

" 4) auto indentation
set autoindent
set cindent

" 5) tab space
set ts=4 " number of spaces of '\t' for printing
set sts=2 " number of spaces when tab key is typed
set shiftwidth=2 " space number for autoindent

" 6) show last status
" 0: disable, 1: enable when the windows are more than two, 2: always enbale
set laststatus=2

" 7) highlight corresponding parenthesis
set showmatch

" 8) smart setting
set ignorecase " ignore case when searching
set smartcase " no automatic ignore case switch for search pattern even if 'ignore' is enabled
set smarttab " for autoindentation
set smartindent " consider some expressions like #include which does not require any switch

" 9) cursor position, current line number
set ruler
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

" 10) encoding
" set encoding=euc-kr ## set when korean is broken
set fileencodings=utf8,euc-kr " some files written in windows have different encoding schemes

" 11) no compatible with original vi
set nocompatible

" 12) no backup file
set nobackup

" 13) theme
" set background=dark
" mkdir -p ~/.vimrc/colors
" cd ~/.vim/colors
" curl -O
" https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
colorscheme jellybeans

" 14) go to previous line when backspace is typed at the start of line or tab
set backspace=start,indent

" 15) no message when the file is edited outside
set autowrite
set autoread

" 16) enable scrolling and resizing using mouse
set mouse=a " n: normal mode, v: visual mode, i: insert mode, a: always

" 17) highlight the line where cursor is located
set cursorline

" 18) clipboard
" set clipboard=unnamedplus " contents copied in vim are automatically stored
" in clipboard
" set paste " when pasting something from outside, disable auto indentation
set clipboard=unnamed

" 19) shortcut
map <F12> <c-t>
map <F11> <c-]>

" 20) unlimit the number of yanked lines
set viminfo='100,<1000,s100,h

" 21) highlight keywords  under cursor
nnoremap <F7> :uf AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
	au! auto_highlight
	augroup! auto_highlight
	setl updatetime=4000
	echo 'Highlight current word: off'
	return 0
  else
	augroup auto_highlight
	  au!
	  au Cursorhold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
	augroup end
	setl updatetime=10
	echo "Highlight current word: on'
	return 1
  endif
endfunction

" 20) prevent swp files from being generated
set noswapfile

""" Plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.bim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	  \| PlugInstall --sync | source $MYVIMRC
	  \| endif

call plug#begin('~/.vim/plugged')
Plug 'majutsushi/tagbar'
call plug#end()

map <F8> :TagbarToggle<CR>

" cpplint
" autocmd BufWritePost *.h,*.cpp,*.cc call Cpplint()
" autocmd FileType cpp,cc,h map <buffer> <F6> :call Cpplint()<CR>


