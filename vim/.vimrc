" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" K will open the man page for whatever the cursor is over.
runtime! ftplugin/man.vim

"Set the tabs to be 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2
"Set the line width to 79 characters
set colorcolumn=80

"The following command makes it possible to switch buffers without writing
set hidden

"Enable line numbering
set number

"Set bash commands to be interactive
set shellcmdflag=-ic

"Looks for tags in containing directories all the way up to root found
set tags=./tags;/

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50    " keep 50 lines of command line history

set ruler   " show the cursor position all the time
set rulerformat=%29(%-16{strftime('%a\ %b\ %e\ %l:%M')}\ \ %-6(%l,%c%V%)\ %P%)

set showcmd   " display incomplete commands
set incsearch   " do incremental searching

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

autocmd Filetype help wincmd L

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  " This removes all autocommands for the current group. This appears
  " right before the autocommands are defined in case this file is read
  " more than once.
  autocmd!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Fuzzy file finding
set path+=**
set wildmenu
set wildmode=longest,full
" set wildignorecase

" Automatically display changes in files that have been changed outside Vim 
set autoread
" bg = dark|light. Adjusts color scheme accordingly
set background=light
" Wrapped lines maintain indentation
set breakindent
set breakindentopt=shift:2,min:40
" Allow % toggling between <,>
set matchpairs+=<:>

" Remappings
" Don't use Ex mode, use Q for formatting. use gQ for ex mode
map Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Toggle relative line numbering
nnoremap R :set nu!<CR>:set rnu!<CR>
" Insert blank lines above or below the cursor
nnoremap <space>O O<ESC>j
nnoremap <space>o o<ESC>k
" A shortcut to hide search highlighting
nnoremap Z :noh<CR>

" Window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"
"
"
"
