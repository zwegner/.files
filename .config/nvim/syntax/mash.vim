" Vim syntax file for mash

runtime! syntax/python.vim

let b:current_syntax = "mash"
let python_highlight_all = 1

syn keyword mashStatement export sizeof offsetof do
syn keyword mashStatement float32 float64 int8 int16 int32 int64 uint8 uint16 uint32 uint64 vec512 const void
syn keyword mashStatement union nextgroup=mashType
syn keyword mashStatement struct nextgroup=mashType
syn keyword mashStatement enum nextgroup=mashType

syn match mashType "[^:(]*" contained

syn match mashFunctionCall "[a-zA-Z0-9_]\+ *("me=e-1

hi link mashFunctionCall Function
hi link mashType Function
hi link mashStatement Statement
