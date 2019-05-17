" $XDG_CONFIG_HOME/nvim/init.vim
" Common command typos
nnoremap :Q :q
nnoremap :W :w

" Editing options
set textwidth=80
set foldmethod=marker
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set noexpandtab
set ignorecase
set smartcase
set number
set relativenumber
set cursorline

" Completions
inoremap ( ()<ESC>i
inoremap { {}<ESC>i
inoremap [ []<ESC>i
inoremap " ""<ESC>i

" Make
noremap <F5> :make<Enter>

" Colors
highlight Normal ctermbg=8
highlight EndOfBuffer ctermbg=0
highlight CursorLine NONE ctermbg=darkgrey
highlight CursorLineNr ctermbg=darkgrey ctermfg=15
highlight ColorColumn ctermbg=0
let &colorcolumn=join(range(&textwidth, 300), ",")
