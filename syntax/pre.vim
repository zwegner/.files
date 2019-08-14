" Vim syntax file for python preprocessor

" Read the c++ syntax to start with
runtime! syntax/cpp.vim
unlet b:current_syntax

" Get python syntax working inside preprocessor blocks
syntax include @Python syntax/python.vim

" Preprocessor defines--for python
syn region cPrePy start="<@" end="@>" keepend contains=@Python fold
hi def link cPrePy PreProc
syn region cPrePyExpr start="<$" end="$>" keepend contains=@Python
hi def link cPrePyExpr PreProc

"syn region block start="{" end="}" fold

let b:current_syntax = "pre"
