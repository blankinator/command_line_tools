"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup

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

" enable search highlighting
set hlsearch

" paste multiple times
xnoremap p pgvy

" close tab with ctr + w
map" set the leader key to space
let mapleader = "\<Space>"

" map close tab to ctrl + 2
nmap <leader>w :q<CR>
nmap <leader>W :q!<CR>

" split pane
nmap <leader>vs :vs<CR>
nmap <leader>hs :hs<CR>

" clear search highlighting
map <esc> :noh<CR>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vim debugger plugin
Plugin 'vim-vdebug/vdebug'

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" simplefold plugin
Plugin 'tmhedberg/SimpylFold'

" python aut-ident plugin
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Yggdroot/indentLine'

" python autocomplete plugin
Bundle 'Valloric/YouCompleteMe'

"Plugin 'davidhalter/jedi-vim'
" for better usage of splits in vim
"let g:jedi#use_splits_not_buffers = "left"
"let g:jedi#use_tabs_not_buffers = 1
" automatically select the first line in the popup for better flow
"let g:jedi#popup_select_first = 0

" terraform plugin
Plugin 'hashivim/vim-terraform'
let g:terraform_aling=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" python syntax checking
Plugin 'vim-syntastic/syntastic'

" python PEP8 checking
Plugin 'nvie/vim-flake8'
Plugin 'tell-k/vim-autopep8'
autocmd FileType python noremap <buffer> <leader>r :call Autopep8()<CR>

" auto pairs of brackets etc.
Plugin 'jiangmiao/auto-pairs'

" rainbow brackets
Plugin 'luochen1990/rainbow'
" enable by default
au BufEnter * RainbowToggle
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'markdown': {
\			'parentheses_options': 'containedin=markdownCode contained',
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'], 
\		},
\		'haskell': {
\			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'], 
\		},
\		'vim': {
\			'parentheses_options': 'containedin=vimFuncBody', 
\		},
\		'perl': {
\			'syn_name_prefix': 'perlBlockFoldRainbow', 
\		},
\		'stylus': {
\			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
\		},
\		'css': 0, 
\	}	
\}

" better commenting
Plugin 'preservim/nerdcommenter'
" let the leader key to space Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
"" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }
"" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1"

" python color_scheme plugin
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" plugin for easier file browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'

set modifiable

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
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'

" git integration
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

if has('gui_running')
	set background=dark
	colorscheme solarized
else
	colorscheme deus
endif
      
" powerline plugin
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" class outline viewer plugin
Plugin 'majutsushi/tagbar'
nmap <leader>c :TagbarToggle<CR>

" syntax highlighting
Plugin 'dense-analysis/ale'
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}
let g:ale_fixers = {
      \    'python': ['yapf'],
      \}
"nmap <leader>r :ALEFix<CR>
let g:ale_fix_on_save = 1
function! LinterStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))

	let l:all_errors = l:counts.error + l:counts.style_error
	let l:all_non_errors = l:counts.total - l:all_errors

	return l:counts.total == 0 ? '✨ all good ✨' : printf(
		\   '😞 %dW %dE',
		\   all_non_errors,
		\   all_errors
		\)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}

" vim-go plugin
Plugin 'fatih/vim-go'

" buffer explorer plugin
Plugin 'jlanzarotta/bufexplorer'

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
