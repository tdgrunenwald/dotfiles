" ~/.vimrc

" standard settings
syntax on
set foldmethod=marker
set tabstop=4
set shiftwidth=4
set noexpandtab
set nocompatible
set number
set autoindent
set hlsearch

" set syntax colors (this scheme came with my vim install)
colorscheme desert

" autocommands
if has("autocmd")
	augroup vimrc
		" clear autocommands
		autocmd!

		" compile hotkeys
		autocmd FileType markdown map <F5> :!pandoc -f markdown -t latex -s -o %:p:r.pdf %<enter>
		autocmd FileType tex map <F5> :!pdflatex -output-directory %:p:h %<enter>
	augroup END
endif

" set cursor shape to IBeam in insert mode, underline in replace mode, and block in normal mode.
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
