set nocompatible

set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

au BufNewFile,BufRead *.h++ setf cpp

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
	
	" Read in custom syntax files.
	au BufRead,BufNewFile *.pgsql set filetype=pgsql
	au! Syntax pgsql source /etc/vim/syntax/pgsql.vim
	
	"au! Syntax cpp source /etc/vim/syntax/cpp_tabs.vim
	"au! Syntax make source /etc/vim/syntax/cpp_tabs.vim
	
endif

" Select gardener if we have enough colors to make it look good.
if &t_Co == 256
  colorscheme zenburn
else
  colorscheme evening
endif

" Tab stuff.
set sw=2
"set sta
set ts=2
set sts=2
"set sr
"set et

" Appearances.
set nowrap
set number
set listchars+=precedes:<,extends:>
set sidescroll=10

set modeline

hi Search ctermbg=DarkBlue
hi Search guibg=DarkBlue

" Allow mousing.
set mouse=a

" Fixup dumb vim.
if &tty == "putty-256color" || &tty == "screen-256c-b-s"
	set ttymouse=xterm2
endif

" Fix home and end.
set <Home>=[H
set <End>=[F

" toggle between terminal and vim mouse
map <silent><F12> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>
imap <silent><F12> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>
function ShowMouseMode()
    if (&mouse == 'a')
        echo "mouse-vim"
    else
        echo "mouse-xterm"
    endif
endfunction

" Preserve indent level for blank lines.
imap <CR> <CR> <BS>

au BufRead,BufNewFile * syntax match Tab /\t/
