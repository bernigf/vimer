" Vimer 0.0.7
" bernigf@gmail.com

syntax on
set redrawtime=15000
colorscheme pablo 

set softtabstop=4
set shiftwidth=4
set expandtab
"set tabstop=4
set autoindent

set ignorecase

set nowrap

set number

" let g:python_highlight_all

" Define f-string region
autocmd FileType python syntax region pythonFString start=/f\z(['"]\)/ skip=/\\\\\z1/ end=/\z1/ contains=pythonFStringExpr

" Match everything inside {}
autocmd FileType python syntax region pythonFStringExpr matchgroup=Delimiter start=/{/ end=/}/ contained

" Apply highlighting
autocmd FileType python highlight link pythonFStringExpr Special
autocmd FileType python highlight link Delimiter Identifier 

