syntax on
set number
set colorcolumn=80 textwidth=80 "80 characters line
set cursorline "highlight cursor line
set lazyredraw
set hidden "buffers

"Default indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

set wildmenu

"colorscheme apprentice

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

Plug 'romainl/Apprentice'

call plug#end()
