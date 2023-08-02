" VIMer v0.0.1
" 
" bernigf@gmail.com

set nocompatible              " be iMproved, required
filetype off                  " required

"set number
set ignorecase
set nowrap
set updatetime=2000

set tabstop=2
set softtabstop=2   " Number of spaces used for indentation
set shiftwidth=2    " Number of spaces used for each indentation level
set expandtab 
set autoindent
filetype plugin indent on

" colorscheme nord
colorscheme afterglow

syntax on

set viminfo='1000,f1
autocmd BufWritePre * normal! ms
autocmd VimLeave * normal! `s

function! SaveLastLine()
    let v:errmsg = ''
    try
        let line = line('.')
        call writefile([line], $HOME . '/.vim_last_line')
    catch
        let v:errmsg = v:exception
    endtry
endfunction

function! RestoreLastLine()
    let v:errmsg = ''
    let last_line_file = $HOME . '/.vim_last_line'
    if filereadable(last_line_file)
        let line = readfile(last_line_file)[0]
        if line =~ '^\d\+$' && line <= line('$')
            execute line
        endif
    endif
    call delete(last_line_file)
endfunction

augroup RememberLastLine
    autocmd!
    autocmd VimLeavePre * call SaveLastLine()
    autocmd VimEnter * call RestoreLastLine()
augroup END
autocmd VimLeave * echo "remoteVIM > Last edited line: " . line(".")

" Switch background color when entering or leaving insert mode

highlight Normal ctermbg=NONE
autocmd InsertEnter * highlight Normal ctermbg=235
autocmd InsertLeave * highlight Normal ctermbg=NONE

" =====
" Status line char / line pos
" =====
"
" set laststatus=2
" set statusline=%<%f\ %h%m%r%=%b\ [%l,%v][%p%%]\ %L/%{line('$')}

" =====
" Status bar on top with current function name
" =====
"

" Define a function to get the current function name
function! GetCurrentFunction()
    let lnum = line('.')
    while lnum > 0
        let line_content = getline(lnum)
        if line_content =~? '\v^(def |function )'
            let function_name = ""
            if line_content =~? '^def '
                let function_name = substitute(line_content, '^def\s\+', '', '')
            endif
            if line_content =~? '^function '
                let function_name = substitute(line_content, '^function\s\+', '', '')
            endif
            let function_name_short = strpart(function_name, 0, 50)
            " echo "Function name: " . function_name
            return function_name_short
        endif
        let lnum = lnum - 1
    endwhile
    return ""
    " echo "No function found."
endfunction

set laststatus=2
set statusline=%<%#FileNameColor#%f\ >>\ %#FunctionColor#\ %{GetCurrentFunction()}\ %#StatusBarColor#%h%m%r%=%b\ [%l,%v][%p%%]\ %L/%{line('$')}

highlight FileNameColor guifg=black ctermfg=black guibg=white ctermbg=white
highlight FunctionColor guifg=white ctermfg=white guibg=darkgreen ctermbg=darkgreen
highlight StatusBarColor guifg=black ctermfg=black guibg=yellow ctermbg=yellow
