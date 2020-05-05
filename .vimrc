python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'




set laststatus=2
set number
set nocompatible              " required
filetype off                  " required

" disable hidden buffers, i.e make vim behave like any other multi file editor
set hidden

set encoding=utf-8
set t_Co=256

" set the leader key to space
let mapleader = "\<Space>"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" simplefold plugin
Plugin 'tmhedberg/SimpylFold'

" python aut-ident plugin
Plugin 'vim-scripts/indentpython.vim'

" python autocomplete plugin
Bundle 'Valloric/YouCompleteMe'

" python syntax checking
Plugin 'vim-syntastic/syntastic'

" python PEP8 checking
Plugin 'nvie/vim-flake8'

" python color_scheme plugin
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" plugin for easier file browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" automatically open nerdtree
autocmd StdinReadPre * let s:std_in=1
" open nerdtree in empty vim session
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" shortcut for opening nerdtree
map <leader>e :NERDTreeToggle<CR>
" close vim if only session is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" let nerdtree show hidden files
let NERDTreeShowHidden=1

" better searching in vi
Plugin 'kien/ctrlp.vim'

" git integration
Plugin 'tpope/vim-fugitive'

if has('gui_running')
	set background=dark
	colorscheme solarized
else
	colorscheme zenburn
endif
      
" add toggle for dark and light mode
"call togglebg#map("<F5>")

" pretty python code
let python_highlight_all = 1
syntax on

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <leader>f za

" better python identation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop= |2
    \ set shiftwidth=2


" flag unnecessary whitespace in python files
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" additional options for youcompleteme
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir,
	'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF
