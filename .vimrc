" Vim 8 .vimrc
" author: Michael Farrell
" contact: michaeldavidfarrell@gmail.com
" date: Mar 7 2019

" vim-plug plugin manager
call plug#begin('~/.vim/plugged')

" Typing
Plug 'dense-analysis/ale'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
"Plug 'Raimondi/delimitMate'
"Plug 'taketwo/vim-ros'
Plug 'lervag/vimtex'
"Plug 'triglav/vim-visual-increment'

" Multi-entry selection UI. FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Utils
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mg979/vim-visual-multi'
Plug 'djoshea/vim-autoread'
Plug 'danro/rename.vim'

" Style
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'nvie/vim-flake8'
Plug 'tell-k/vim-autopep8'
Plug 'rhysd/vim-clang-format'

call plug#end()

"""""""" Custom Settings """"""""""""""
" syntax highlighting and filetype specific features
syntax on
filetype on
filetype plugin on
filetype indent on

" Always copy and paste to clipboard
"set clipboard=unnamedplus

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

" leave end of file as is (newline or not)
set nofixeol

" fold method syntax automatically folds functions, etc
"set foldmethod=syntax

" 80 character per line
"set textwidth=120

" Highlight one column after limit
"set colorcolumn=+1

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

" Delete blank lines from end of .h/.cpp files
function! TrimEndLines()
    let save_cursor = getpos(".")
    silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

autocmd BufWritePre *.h call TrimEndLines()
autocmd BufWritePre *.cpp call TrimEndLines()

"""""""" Custom Keys """"""""""""""
" Set space for the leader
let mapleader = "\\"
nmap <space> <leader>
vmap <space> <leader>

" Escape Mappings for insert and visual modes
"inoremap jk <esc>
"vnoremap jk <esc>

" Mappings to move up and down faster
"nnoremap J 10j
"nnoremap K 10k
"vnoremap J 10j
"vnoremap K 10k

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
"let g:ale_linters = {'cpp': ['cquery', 'cpplint'], 'python':['pyls'], 'cmake': ['cmakelint']}
"let g:ale_linters = {'cpp': ['cquery'], 'python':['pyls'], 'cmake': ['cmakelint']}
let g:ale_linters = {'cpp': ['ccls'], 'python':['pyls'], 'cmake': ['cmakelint']}
let g:ale_fixers = {'cpp': ['clang-format'], 'python':['autopep8']}
let g:ale_fix_on_save = 0
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
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_echo_cursor = 0
let g:ale_cpp_ccls_executable = '/home/m/installed_apps/ccls/Release/ccls'
let g:ale_cpp_ccls_init_options = {
\   'cache': {
\       'directory': '/tmp/ccls/cache',
\   },
\ }

"" Autopep8
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_disable_show_diff=1

" Show errors in airline status bar
let g:airline#extensions#ale#enabled = 1

"" Scroll through autocomplete options with Tab
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Use Ale to jumpy to definition, etc.
nnoremap <silent> gh :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap <silent> ge :ALEDetail<CR>
nnoremap <leader>aj :ALENext<CR>
nnoremap <leader>ak :ALEPrevious<CR>

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
"nmap <Leader>C :ClangFormatAutoToggle<CR>

" Vim-ROS
" Open .h/.cpp in a vsplit
"command! -nargs=0 AV exec ':vsplit | A'
" Git Gutter mappings
nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gN :GitGutterPrevHunk<CR>
nnoremap <leader>gs :GitGutterStageHunk<CR>
nnoremap <leader>gp :GitGutterPreviewHunk<CR>
nnoremap <leader>gu :GitGutterUndoHunk<CR>
nnoremap <leader>gb :Gblame<CR>

" FZF
" leader + f to search files
" Ctrl+t, Ctrl+x, Ctrl+v to open in tab, split, vsplit
"nnoremap <leader>f :GFiles<CR>
nnoremap <leader>f :Files<CR>
" leader + us (for UltiSnips) to insert a snippet
nnoremap <leader>s :Snippets<CR>
" Silver searcher to grep into all files in current path (ignoring .gitignore files)

command! -bang -nargs=* Ag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <leader>ag :Ag<space>

let g:fzf_layout = { 'down': '40%' }
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
let $FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

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

" vim-visual-multi
let g:VM_leader            = '\\'
let g:VM_mouse_mappings    = 1
let g:VM_theme             = 'iceblue'

let g:VM_maps = {}
let g:VM_maps["Undo"]      = 'u'
let g:VM_maps["Redo"]      = '<C-r>'
let g:VM_maps["Add Cursor Down"] = '<C-j>'
let g:VM_maps["Add Cursor Up"]   = '<C-k>'

" Load all plugins now, generate help tags, errors and messages ignored
packloadall
silent! helptags ALL
