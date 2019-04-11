" ~/.vimrc

" Basic settings
set foldmethod=marker
set tabstop=4
set shiftwidth=4
set noexpandtab
set nocompatible
set number
set relativenumber
set autoindent
set smartindent
set hlsearch
set incsearch
set textwidth=80
set showcmd
set background=dark

" Syntax and filetype settings
syntax on
filetype plugin indent on
colorscheme desert

" Helps with slow release of shift key when trying to exit
nnoremap :Q :q

" Automatically insert matching brace|quote
inoremap ( ()<ESC>i
inoremap { {}<ESC>i
inoremap [ []<ESC>i
inoremap " ""<ESC>i

" Autocommands
if has("autocmd")
	augroup vimrc
		" Clear autocommands
		autocmd!

		" Load a template for the given file extention if it exists
		" Templates should be ~/.vim/skel and have the same name as the extension
		autocmd BufNewFile * if !empty(expand("%:t:e")) && !empty(glob("~/.vim/skel/" . expand('%:t:e'))) | 0r ~/.vim/skel/%:t:e | endif

		" Compile hotkeys
		autocmd FileType markdown map <F5> :!pandoc -f markdown -t latex -s -o %:p:r.pdf %<enter>
		autocmd FileType tex map <F5> :!pdflatex -output-directory=%:p:h %<enter>
	augroup END
endif

" Set cursor shape to IBeam in insert mode, underline in replace mode, and block in normal mode.
" Sources http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
"	      https://vi.stackexchange.com/questions/3379/cursor-shape-under-vim-tmux
"         https://vi.stackexchange.com/questions/7306/vim-normal-and-insert-mode-cursor-not-changing-in-gnu-screen
if &term=="screen" || &term=="screen-256color"
	let &t_SI = "\eP\e[6 q\e\\"
	let &t_SR = "\eP\e[4 q\e\\"
	let &t_EI = "\eP\e[2 q\e\\"
elseif &term=="tmux" || &term=="tmux-256color"
	let &t_SI = "\<esc>Ptmux;\<esc>\e[6 q\<esc>\\"
	let &t_SR = "\<esc>Ptmux;\<esc>\e[4 q\<esc>\\"
	let &t_EI = "\<esc>Ptmux;\<esc>\e[2 q\<esc>\\"
elseif &term!="linux"
	let &t_SI = "\e[6 q"
	let &t_SR = "\e[4 q"
	let &t_EI = "\e[2 q"
endif
