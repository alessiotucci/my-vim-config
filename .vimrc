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
"augroup AutoTags
"  autocmd!
"  autocmd BufWritePost,BufReadPost * silent! !ctags -R .
"augroup END


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

" This uses the standard unicode right arrow (U+2192). It is thinner, but Windows will treat it as text !
" Replace your current set listchars line with this:
" set listchars=tab:→\ ,space:·
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

" ==============================================================================
" Cute Header Creator (F5)
" ==============================================================================
let s:asciiart = [
            \"   /\_/\  ",
            \"  ( o.o ) ",
            \"  > ^ <   ",
            \"  /   \   ",
            \" (|_|)_)  "
            \]

let s:start     = '#'
let s:end       = '#'
let s:fill      = '*'
let s:length    = 80
let s:margin    = 5

let s:types     = {
            \'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.tpp$\|\.ipp$\|\.cxx$\|\.go$\|\.rs$\|\.php$\|\.py$\|\.java$\|\.kt$\|\.kts$':
            \['/*', '*/', '*'],
            \'\.htm$\|\.html$\|\.xml$':
            \['<!--', '-->', '*'],
            \'\.js$\|\.ts$':
            \['//', '//', '*'],
            \'\.tex$':
            \['%', '%', '*'],
            \'\.ml$\|\.mli$\|\.mll$\|\.mly$':
            \['(*', '*)', '*'],
            \'\.vim$\|\vimrc$':
            \['"', '"', '*'],
            \'\.el$\|\emacs$\|\.asm$':
            \[';', ';', '*'],
            \'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
            \['!', '!', '/'],
            \'\.lua$':
            \['--', '--', '-']
            \}

function! s:filetype()
    let l:f = s:filename()
    let s:start = '#'
    let s:end   = '#'
    let s:fill  = '*'

    for type in keys(s:types)
        if l:f =~ type
            let s:start  = s:types[type][0]
            let s:end    = s:types[type][1]
            let s:fill   = s:types[type][2]
        endif
    endfor
endfunction

function! s:ascii(n)
    return s:asciiart[a:n - 3]
endfunction

function! s:textline(left, right)
    let l:left = strpart(a:left, 0, s:length - s:margin * 2 - strlen(a:right))
    return s:start . repeat(' ', s:margin - strlen(s:start)) . l:left . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right . repeat(' ', s:margin - strlen(s:end)) . s:end
endfunction

function! s:hostname()
    let l:host = system('hostname')->trim()
    return v:shell_error ? 'unknown' : l:host
endfunction

function! s:osinfo()
    let l:os = system('uname -srm')->trim()
    return v:shell_error ? 'unknown' : l:os
endfunction

function! s:cpu_model()
    let l:cpu = system('grep -m1 "model name" /proc/cpuinfo | cut -d ":" -f2 | sed "s/^ *//" | tr -d "\n"')
    return v:shell_error ? 'unknown' : l:cpu
endfunction

function! s:memory()
    let l:mem = system('grep -m1 "MemTotal" /proc/meminfo | cut -d ":" -f2 | sed "s/^ *//" | tr -d "\n"')
    return v:shell_error ? 'unknown' : l:mem
endfunction

function! s:line(n)
    if a:n == 1 || a:n == 9
        return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
    elseif a:n == 2 || a:n == 8
        return s:textline('', '')
    elseif a:n == 3
        return s:textline('Host: ' . s:hostname(), s:ascii(a:n))
    elseif a:n == 4
        return s:textline('File: ' . s:filename(), s:ascii(a:n))
    elseif a:n == 5
        return s:textline('Created: ' . s:date() . ' | By: ' . s:user() . ' <' . s:mail() . '>', s:ascii(a:n))
    elseif a:n == 6
        return s:textline('Updated: ' . s:date(), s:ascii(a:n))
    elseif a:n == 7
        return s:textline('OS: ' . s:osinfo() . ' | CPU: ' . s:cpu_model() . ' | Mem: ' . s:memory(), s:ascii(a:n))
    endif
endfunction

function! s:user()
    return exists('g:user') ? g:user : strlen($USER) ? $USER : 'marvin'
endfunction

function! s:mail()
    return exists('g:mail') ? g:mail : strlen($MAIL) ? $MAIL : 'marvin@42.fr'
endfunction

function! s:filename()
    let l:filename = expand("%:t")
    return strlen(l:filename) ? l:filename : "< new >"
endfunction

function! s:date()
    return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function! s:insert()
    let l:line = 9
    call append(0, "")
    while l:line > 0
        call append(0, s:line(l:line))
        let l:line -= 1
    endwhile
endfunction

function! s:update()
    call s:filetype()
    if getline(6) =~ s:start . repeat(' ', s:margin - strlen(s:start)) . "Updated: "
        if &mod
            call setline(6, s:line(6))
        endif
        call setline(4, s:line(4))
        return 0
    endif
    return 1
endfunction

function! s:stdheader()
    if s:update()
        call s:insert()
    endif
endfunction

" Setup commands and autocmd
command! CuteHeader call s:stdheader()
nnoremap <silent> <F5> :CuteHeader<CR>
augroup HeaderAutoUpdate
    autocmd!
    autocmd BufWritePre * call s:update()
augroup END
