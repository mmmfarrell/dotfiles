" Vim 8 .vimrc
" author: Michael Farrell
" contact: michaeldavidfarrell@gmail.com
" date: Mar 7 2019

" vim-plug plugin manager
call plug#begin('~/.vim/plugged')

" Typing
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
"Plug 'taketwo/vim-ros'
Plug 'lervag/vimtex'
Plug 'triglav/vim-visual-increment'

" Multi-entry selection UI. FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Utils
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/a.vim'
Plug 'airblade/vim-gitgutter'

" Style
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'nvie/vim-flake8'
Plug 'rhysd/vim-clang-format'

call plug#end()

"""""""" Custom Settings """"""""""""""
" syntax highlighting and filetype specific features
syntax on
filetype on
filetype plugin on
filetype indent on

" Always copy and paste to clipboard
set clipboard=unnamedplus

" Colorscheme
set termguicolors
let g:gruvbox_contrast_dark="hard"
set background=dark
colorscheme gruvbox

" Be improved
set nocompatible

" Relative line numbering with absolute line number on current line
set relativenumber
set number

" Show gutter
"set signcolumn=yes

" Always display status bar
set laststatus=2

" swp files are the worst, disable them
set nobackup
set noswapfile

" dont highlight search, no incremental search
set nohls
"set noincsearch
set incsearch

" Don't redraw while executing macros
set lazyredraw 

" allows pattern matching with special characters
set magic 

" show the cursor position all the time
set ruler   

" fold method syntax automatically folds functions, etc
"set foldmethod=syntax

" 80 character per line
set textwidth=80

" Highlight one column after limit
set colorcolumn=+1

" spaces everywhere, indents are 4 spaces
set tabstop=2
set expandtab
set shiftwidth=2
"set shiftwidth=4 " Why does this keep resetting?
set smarttab

autocmd FileType make set noexpandtab softtabstop=0
autocmd FileType c setlocal ts=2 sw=2 expandtab
autocmd FileType cpp setlocal ts=2 sw=2 expandtab
autocmd FileType py setlocal ts=4 sw=4 expandtab

" Don't assume I want a line comment after another line comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"""""""" Custom Keys """"""""""""""
" Set space for the leader
let mapleader = "\\"
nmap <space> <leader>
vmap <space> <leader>

" Escape Mappings for insert and visual modes
inoremap jk <esc>
vnoremap jk <esc>

" Mappings to move up and down faster
nnoremap J 10j
nnoremap K 10k
vnoremap J 10j
vnoremap K 10k

" Mappings to edit .vimrc/init.vim and source/save .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Cpp stuff: nice curly braces
inoremap {<CR> {<CR>}<Esc>ko

""""""""""" Plugins """"""""""""""""""
"" ALE
" Use LSP linters
" Install cquery https://github.com/cquery-project/cquery
" Install pyls https://github.com/palantir/python-language-server
let g:ale_linters = {'cpp': ['ccls', 'cpplint'], 'python':['pyls'], 'cmake': ['cmakelint']}
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '%severity% %s% [%linter%% code%]'
let g:ale_c_parse_compile_commands=1
"let g:ale_cpp_clangtidy_checks = ['modernize', 'google', 'clang-analyzer', 'performance', 'readability', 'bugprone']
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_echo_cursor = 0
let g:ale_cpp_ccls_init_options = {
\   'cache': {
\       'directory': '/tmp/ccls/cache',
\   },
\ }

" Show errors in airline status bar
let g:airline#extensions#ale#enabled = 1

"" Scroll through autocomplete options with Tab
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Use Ale to jumpy to definition, etc.
nnoremap <silent> gh :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gr :ALEFindReferences<CR>

" UltiSnips
let g:UltiSnipsSnippetDirectories=["~/.vim/plugged/vim-snippets/UltiSnips", "/home/mmmfarrell/.vim/UltiSnips"]
" Ctrl + j to expand snippets and Ctrl+j/Ctrl+k to move forward, back
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Clang format
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
"autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

" Vim-ROS
" Open .h/.cpp in a vsplit
"command! -nargs=0 AV exec ':vsplit | A'

" FZF
" leader + f to search files
" Ctrl+t, Ctrl+x, Ctrl+v to open in tab, split, vsplit
nnoremap <leader>f :Files<CR>
" leader + us (for UltiSnips) to insert a snippet
nnoremap <leader>s :Snippets<CR>
" Silver searcher to grep into all files in current path (ignoring .gitignore files)
nnoremap <leader>ag :Ag<CR>

" NerdTree
" Start nerdtree if start vim with no file specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open/Close NerdTree with Ctrl + N
map <C-n> :NERDTreeToggle<CR>

" VimAirline
" Note: If symbols don't appear install them with
" `sudo apt install fonts-powerline` Ubuntu
let g:airline_powerline_fonts = 1
let g:airline_theme = "dark"

" Tmuxline
" Note: this plugin is used to generate pretty formats for tmux that are saved
" and then loaded by tmux on startup. That way your tmux always looks nice, not
" just after you start vim.
let g:airline#extensions#tmuxline#enabled = 0

" Make vimtex use zathura
let g:vimtex_view_method = 'zathura'

" Visual Increment
" Allows to increment or decrement letters too
set nrformats=alpha

" Load all plugins now, generate help tags, errors and messages ignored
packloadall
silent! helptags ALL
