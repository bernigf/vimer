" VIMer v0.0.5a
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
"filetype plugin indent on

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
        if line_content =~? '\v^(def |function |async function )'

            let function_name = ""

            " Python functions
            if line_content =~? '^def '
                let function_name = substitute(line_content, '^def\s\+', '', '')
            endif

            " Javascript functions
            if line_content =~? '^function '
                let function_name = substitute(line_content, '^function\s\+', '', '')
            endif

            " Javascript Async functions
            if line_content =~? '^async function '
                let function_name = substitute(line_content, '^async function\s\+', '', '')
            endif

            let function_name_max = 30
            let function_name_short = strpart(function_name, 0, function_name_max)

            " echo "Function name: " . function_name
            return function_name_short
        endif
        let lnum = lnum - 1
    endwhile
    return ""
    " echo "No function found."
endfunction

function! StatusLineFile()
  let filename = expand('%:p')
  if strlen(filename) > 25
    let filename = fnamemodify(filename, ':t')
  endif
  return filename
endfunction

set laststatus=2

highlight CursorColor guifg=green ctermfg=green gui=bold cterm=bold
"set statusline=%<%#FileNameColor#%f\ >>\ %#FunctionColor#\ %{GetCurrentFunction()}\ %#StatusBarColor#%h%m%r%=%b\ [%l,%v][%p%%]\ %L/%{line('$')}
set statusline=%<%#FileNameColor#\ <\ %{StatusLineFile()}\ >\ %#FunctionColor#\ %{GetCurrentFunction()}\ %#StatusBarColor#%=\ %#CursorColor#%v%#StatusBarColor#:%l/%L\ [%p%%]

highlight FileNameColor guifg=black ctermfg=black guibg=white ctermbg=white gui=bold cterm=bold
highlight FunctionColor guifg=white ctermfg=LightGray guibg=darkgreen ctermbg=darkgreen gui=bold cterm=bold
"highlight FunctionColor guifg=white ctermfg=grey guibg=darkblue ctermbg=darkblue gui=bold cterm=bold
highlight StatusBarColor guifg=black ctermfg=white guibg=LightGray ctermbg=black gui=bold cterm=bold

" =====
" Line commenter mapped to M key (Shift+m)
" =====
"
function! InsertComment()
    " Store the current cursor position
    let save_cursor = getpos('.')
    
    " Get the first character of the line
    let first_char = getline('.')[0]

    " Get the current line
    let current_line = getline('.')

    if current_line =~? '^\s*# '
        " Line starts with '#', remove the '#'
        normal! ^xx 
    elseif current_line =~? '^\s*#\s*'
        " Line starts with '#', remove the '#'
        normal! ^x 
    else
        " Line doesn't start with '#', insert '#'
        normal! I# 
    endif
 
    " Exit insert mode
    stopinsert
    
    " Restore the cursor position
    call setpos('.', save_cursor)
endfunction

" Map 'M' to call the custom function in normal mode
nnoremap M :call InsertComment()<CR>

" =====
" Map backspace in REPLACE mode to delete a character
" instead of moving a position to the left
" =====

set backspace=indent,eol,start

function! DeleteInReplaceMode()

  let col = col('.')
  let line = getline('.')

  if v:insertmode == 'i'
    if col == 1
      normal! kJ
    elseif col == len(line)
      normal! x
    else
      normal! hx
    endif
  endif

  if v:insertmode == 'R'
    let col = col('.')
    if col > 1 | exe "normal! lX" | endif 
  endif

endfunc

inoremap <silent> <BS> <C-O>:call DeleteInReplaceMode()<CR>

