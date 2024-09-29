"--------------------------------------------------
" enter the current millenium
set nocompatible
" after watching the video
filetype plugin on
"--------------------------------------------------
" set the visual bell
set vb
"--------------------------------------------------
colorscheme elflord
"--------------------------------------------------
" Show line numbers
set number
"--------------------------------------------------
" Enable syntax highlighting
syntax on
"--------------------------------------------------
" Show status bar
set laststatus=2
set ruler
"--------------------------------------------------
" Enable mouse support
set mouse=a
" Header for 42 ecole: ----------------------------------
let g:user42 = 'atucci'
let g:mail42 = 'atucci@student.42.fr'
"--------------------------------------------------------
"---------------------------------------------------------
"source: https://jeffkreeftmeijer.com/vim-number
"--------------------------------------------------------
:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END
"--------------------------------------------------------

"----------------------*** Netrw ***--------------------- 
" Open Netrw when Vim starts
autocmd VimEnter * :Vexplore
" Set Netrw to open in a vertical split
let g:netrw_winsize = 18
" Hide some unnecessary details in Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
"-------------------------------------------------------
set textwidth=80
set colorcolumn=80
"--------------------------------------------------------
" finding files in subdir etc
set path+=**
" display alla mathchifiles when we tab complete
set wildmenu
" -------------------------------------------------------
" this is for customize the color of tabs in vim
hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
hi TabLine ctermfg=Blue ctermbg=Yellow
hi TabLineSel ctermfg=Red ctermbg=8

"----------------------------------------
" this might not work on windows
" create the 'tags' file (may need to install ctags first)
" command! MakeTags !gtags -R .

" Automatically create and update tags file on file save or open
augroup AutoTags
  autocmd!
  autocmd BufWritePost,BufReadPost * silent! !ctags -R .
augroup END


"----------------------------------------------------------
"display useful information in the status lines
" Set the status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

"----------------------------------------------------------------"
" I have updated this configuartion to change also the background"
"----------------------------------------------------------------"
" Normal mode
hi StatusLine ctermfg=White ctermbg=DarkBlue cterm=NONE

" Insert mode
au InsertEnter * colorscheme industry
au InsertEnter * hi StatusLine ctermfg=Black ctermbg=DarkCyan cterm=NONE
au InsertEnter * highlight SpecialKey ctermfg=DarkGray guifg=DarkGray
" Command mode
au CmdlineEnter : hi StatusLine ctermfg=Black ctermbg=DarkGreen cterm=NONE
au CmdlineEnter * highlight SpecialKey ctermfg=DarkGray guifg=DarkGray

" Reset the color
au InsertLeave *,CmdlineLeave : colorscheme elflord
au InsertLeave *,CmdlineLeave : hi StatusLine ctermfg=White ctermbg=DarkBlue cterm=NONE
au InsertLeave * highlight SpecialKey ctermfg=DarkGray guifg=DarkGray

"----------------------------------------------------------
" Set	tabsto and shiftwidth to 1 to make tab one char wide
set tabstop=4
set shiftwidth=1
" Enable auto-indentation
set autoindent
set smartindent
set cindent
" Show tabs as -  and spaces as · 
" Here is to type them out
" set listchars=tab:\u27A1\ ,space:\u00B7
set listchars=tab:➡\ ,space:·
set list

" Customize colors for the special characters
highlight SpecialKey ctermfg=DarkGray guifg=DarkGray

"    this is a comment with spaces
"	this	is    a		comment with    tabs            double tabl

 " Show cursorline
set cursorline
" Set the cursor line highlight
highlight CursorLine ctermbg=88

"hi CurorLine   cterm= ctermbg=Red
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


