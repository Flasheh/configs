"                                            "
""                  .vimrc                  ""
"""                                        """
"""" ~ created by Flasheh                 """"
""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""Set colorscheme"""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""
if &t_Co < 256
    colorscheme miro8
else
    colorscheme miromiro 
endif

""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""Settings"""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax on

"" General
set nocompatible        " leave the old ways behind...
set nowrap              " don't wrap lines
set nobackup            " disable backup files (filename~)
set splitbelow          " place new files below the current
set clipboard+=unnamed  " yank and copy to X clipboard
set encoding=utf-8      " UTF-8 encoding for all new files
set backspace=2         " full backspacing capabilities (indent,eol,start)
set number              " show line numbers
set ww=b,s,h,l,<,>,[,]  " whichwrap -- left/right keys can traverse up/down
set linebreak           " attempt to wrap lines cleanly
set wildmenu            " enhanced tab-completion shows all matching cmds in a popup menu
set wildmode=list:longest,full
set mouse=a         	" Enable the use of the mouse

"" Tab stuff
set noexpandtab         " don't insert spaces instead of tabs
set tabstop=4           " tabs appear as n number of columns
set shiftwidth=4        " n cols for auto-indenting
set autoindent          " auto indents next new line

"" searching
set hlsearch            " highlight all search results
set incsearch           " increment search
set ignorecase          " case-insensitive search
set smartcase           " uppercase causes case-sensitive search

"" space bar un-highligts search
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

"" Allows writing to files with root priviledges
cmap w!! w !sudo tee % > /dev/null
