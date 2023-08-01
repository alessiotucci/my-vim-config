" Show line numbers
set number

" Enable syntax highlighting
syntax on

" Show cursorline
set cursorline

" Enable mouse support
set mouse=a

" Set	tabsto and shiftwidth to 1 to make tab one char wide
set tabstop=1
set shiftwidth=1


" Show tabs as -  and spaces as · 
set listchars=tab:→°,space:·
set list

" Customize colors for the special characters
highlight SpecialKey ctermfg=LightGray guifg=LightGray

"       this is a comment with spaces
"	this				is      a       comment with    tabs            double tabl

 " Show cursorline
 set cursorline
hi CursorLine   cterm=NONE ctermbg=Darkgreen

" set the fucking backspace
set backspace=indent,eol,start

" Use the system clipboard for copy and paste operations
"set clipboard=unnamedplus
set clipboard^=unnamed,unnamedplus

" Set font preferences for GUI environments
if has("gui_running")
  if has("gui_gtk2")
    " Use the Inconsolata font with size 12 on GTK2
    set guifont=Inconsolata\ 12
  elseif has("gui_gtk3")
    " Use the Inconsolata font with size 12 on GTK3
    set guifont=Inconsolata\ 12
  elseif has("gui_photon")
    " Use the Inconsolata font with size 12 on Photon
    set guifont=Inconsolata\ 12
  elseif has("gui_win32")
    " Use the Consolas font with size 11 and ANSI character set on Windows
    set guifont=Consolas:h11:cANSI
  endif
endif

