"--------------------------------------------------
" General Settings
"--------------------------------------------------
set nocompatible
filetype plugin on
set vb " Visual bell
set number
syntax on
set laststatus=2
set ruler
set mouse=a
set encoding=utf-8

"--------------------------------------------------
" User Identification (Used for the Header)
"--------------------------------------------------
let g:user42 = 'atucci'
let g:mail42 = 'atucci@student.42.fr'

"--------------------------------------------------
" Default Colorscheme (Normal Mode)
"--------------------------------------------------
colorscheme elflord

"--------------------------------------------------
" Relative Number Toggle
"--------------------------------------------------
" Source: https://jeffkreeftmeijer.com/vim-number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

"--------------------------------------------------
" Netrw Configuration
"--------------------------------------------------
autocmd VimEnter * :Vexplore
let g:netrw_winsize = 18
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4

"--------------------------------------------------
" Text & Formatting
"--------------------------------------------------
set textwidth=80
set colorcolumn=80
set path+=**
set wildmenu

" Tab settings
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set cindent

"--------------------------------------------------
" Visual Character Settings
"--------------------------------------------------
" Show tabs as arrow and spaces as dots
set listchars=tab:➡\ ,space:·
set list

" Custom tab colors
hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
hi TabLine ctermfg=Blue ctermbg=Yellow
hi TabLineSel ctermfg=Red ctermbg=8

" Cursor Line
set cursorline
highlight CursorLine ctermbg=88
set backspace=indent,eol,start

" Clipboard
set clipboard^=unnamed,unnamedplus

" Fonts (GUI)
if has("gui_running")
  if has("gui_gtk2") || has("gui_gtk3") || has("gui_photon")
    set guifont=Inconsolata\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

"--------------------------------------------------
" Status Line Configuration
"--------------------------------------------------
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" Default StatusLine color (Normal Mode)
hi StatusLine ctermfg=White ctermbg=DarkBlue cterm=NONE

"----------------------------------------------------------------"
" DYNAMIC BACKGROUND & COLOR LOGIC
"----------------------------------------------------------------"

function! s:ApplyModeColors()
    " 1. PHP Configuration
    if &filetype == 'php'
        colorscheme slate
        " Custom Visual selection color for PHP
        hi Visual ctermbg=DarkMagenta ctermfg=White

    " 2. JavaScript / TypeScript Configuration
    elseif &filetype == 'javascript' || &filetype == 'typescript'
        colorscheme evening
        " Custom Visual selection color for JS
        hi Visual ctermbg=DarkYellow ctermfg=Black

    " 3. All other languages (C, C++, etc.)
    else
        colorscheme industry
        " Standard Visual selection
        hi Visual ctermbg=DarkGray
    endif

    " Apply StatusLine overrides for Insert Mode (Shared logic)
    hi StatusLine ctermfg=Black ctermbg=DarkCyan cterm=NONE
    highlight SpecialKey ctermfg=DarkGray guifg=DarkGray
    highlight CursorLine ctermbg=88

endfunction

function! s:ResetColors()
    " Reset to Normal mode defaults
    colorscheme elflord
    hi StatusLine ctermfg=White ctermbg=DarkBlue cterm=NONE
    highlight SpecialKey ctermfg=DarkGray guifg=DarkGray
    highlight CursorLine ctermbg=88

endfunction

" Automation for Color Switching
augroup AutoColorSwitch
    autocmd!
    " Enter Insert Mode: Apply language specific colors
    autocmd InsertEnter * call s:ApplyModeColors()
    
    " Command Mode: Standard Green status
    autocmd CmdlineEnter : hi StatusLine ctermfg=Black ctermbg=DarkGreen cterm=NONE
    autocmd CmdlineEnter * highlight SpecialKey ctermfg=DarkGray guifg=DarkGray

    " Leave Modes: Reset to Elflord
    autocmd InsertLeave *,CmdlineLeave : call s:ResetColors()
augroup END


" ==============================================================================
" COMPACT HEADER CREATOR (Fixed RAM & Formatting)
" ==============================================================================
let s:header_width = 80
let s:margin_width = 5

let s:types = {
            \ '\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.tpp$\|\.ipp$\|\.cxx$\|\.go$\|\.rs$\|\.php$\|\.py$\|\.java$\|\.kt$\|\.kts$':
            \ ['/*', '*/', '*'],
            \ '\.htm$\|\.html$\|\.xml$':
            \ ['', '*'],
            \ '\.js$\|\.ts$':
            \ ['//', '//', '*'],
            \ '\.tex$':
            \ ['%', '%', '*'],
            \ '\.ml$\|\.mli$\|\.mll$\|\.mly$':
            \ ['(*', '*)', '*'],
            \ '\.vim$\|\vimrc$':
            \ ['"', '"', '*'],
            \ '\.el$\|\emacs$\|\.asm$':
            \ [';', ';', '*'],
            \ '\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
            \ ['!', '!', '/'],
            \ '\.lua$':
            \ ['--', '--', '-']
            \ }

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

function! s:format_row(label, value)
    " Width calculation
    let l:inner_width = s:header_width - (s:margin_width * 2) - strlen(s:start) - strlen(s:end)
    
    let l:content = a:label . ": " . a:value
    
    " Strict truncation to prevent indentation bugs
    if strlen(l:content) > l:inner_width
        let l:content = strpart(l:content, 0, l:inner_width - 3) . "..."
    endif

    let l:padding = l:inner_width - strlen(l:content)

    return s:start . repeat(' ', s:margin_width) . l:content . repeat(' ', l:padding) . repeat(' ', s:margin_width) . s:end
endfunction

function! s:line(n)
    " 1. Top Border
    if a:n == 1
        return s:start . ' ' . repeat(s:fill, s:header_width - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
    
    " 2. File Path
    elseif a:n == 2
        return s:format_row('File', s:relpath())
    
    " 3. Author
    elseif a:n == 3
        return s:format_row('Author', s:user() . ' <' . s:mail() . '>')
    
    " 4. Created Date
    elseif a:n == 4
        return s:format_row('Created', s:date())
    
    " 5. Updated Date
    elseif a:n == 5
        return s:format_row('Updated', s:date())
    
    " 6. System Info
    elseif a:n == 6
        return s:format_row('System', s:osinfo() . ' [' . s:hostname() . ']')
        
    " 7. Hardware Info (Fixed RAM)
    elseif a:n == 7
        return s:format_row('Hardware', s:cpu_model() . ' | RAM: ' . s:memory())

    " 8. Bottom Border
    elseif a:n == 8
        return s:start . ' ' . repeat(s:fill, s:header_width - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
    endif
endfunction

" --- Data Helper Functions ---

function! s:relpath()
    " Returns relative path (e.g., src/main.c) instead of just filename
    return fnamemodify(expand("%"), ":~:.")
endfunction

function! s:hostname()
    let l:host = system('hostname')->trim()
    return v:shell_error ? 'unknown' : l:host
endfunction

function! s:osinfo()
    let l:os = system('uname -s')->trim()
    return v:shell_error ? 'unknown' : l:os
endfunction

function! s:cpu_model()
    " Aggressively cleans CPU string to save space
    let l:cpu = system('grep -m1 "model name" /proc/cpuinfo | cut -d ":" -f2 | sed "s/(R)//g; s/(TM)//g; s/ CPU//g; s/ Processor//g; s/ @.*//g; s/^ *//" | tr -d "\n"')
    return v:shell_error ? 'unknown' : l:cpu
endfunction

function! s:memory()
    " 1. Get string from system
    let l:mem_str = system("awk '/MemTotal/ {print $2}' /proc/meminfo")
    " 2. Convert to number (force integer) to fix 0GB bug
    let l:mem_kb = str2nr(l:mem_str)
    
    if l:mem_kb == 0
        return 'Unknown'
    endif

    " 3. Math
    let l:mem_gb = l:mem_kb / 1024 / 1024
    
    " If less than 1GB, show MB instead
    if l:mem_gb < 1
        return (l:mem_kb / 1024) . 'MB'
    else
        return l:mem_gb . 'GB'
    endif
endfunction

function! s:user()
    return exists('g:user42') ? g:user42 : strlen($USER) ? $USER : 'marvin'
endfunction

function! s:mail()
    return exists('g:mail42') ? g:mail42 : strlen($MAIL) ? $MAIL : 'marvin@42.fr'
endfunction

function! s:filename()
    let l:filename = expand("%:t")
    return strlen(l:filename) ? l:filename : "< new >"
endfunction

function! s:date()
    return strftime("%Y/%m/%d %H:%M:%S")
endfunction

" --- Insertion Logic ---

function! s:insert()
    let l:line = 8
    call append(0, "")
    while l:line > 0
        call append(0, s:line(l:line))
        let l:line -= 1
    endwhile
endfunction

function! s:update()
    call s:filetype()
    " Check line 5 for 'Updated' (Since header is now smaller)
    if getline(5) =~ "Updated: "
        if &mod
            call setline(5, s:line(5))
        endif
        return 0
    endif
    return 1
endfunction

function! s:stdheader()
    if s:update()
        call s:insert()
    endif
endfunction

command! Header call s:stdheader()
nnoremap <silent> <F5> :Header<CR>
augroup HeaderAutoUpdate
    autocmd!
    autocmd BufWritePre * call s:update()
augroup END    
