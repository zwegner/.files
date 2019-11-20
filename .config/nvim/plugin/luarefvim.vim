" luarefvim plugin
" This is somewhat based on CRefVim
" Maintainer: Luis Carvalho <lexcarvalho@gmail.com>
" Last Change: Jun, 3, 2005
" Version: 0.2

" initial setup: avoid loading more than once
if exists("g:loaded_luarefvim")
	finish
endif
let g:loaded_luarefvim = 1

" mappings:
autocmd filetype lua vnoremap <silent> <buffer> <C-H> "hy:call <SID>LookUp('<c-r>h')<CR>
autocmd filetype lua nnoremap <silent> <buffer> <C-H>  :call <SID>LookUp(expand("<cword>"))<CR>
autocmd filetype lua  noremap <silent> <buffer> <Leader>d :help luaref<CR>

function <SID>LookUp(str)
	if a:str == "--" "comment?
		silent! execute ":help lrv-comment"
	elseif a:str == ""
		silent! execute ":help luaref"
	else
		silent! execute ":help lrv-" . a:str
		if v:errmsg != ""
			echo "luarefvim: \`" . a:str . "\' not found"
		endif
	endif
endfunction
