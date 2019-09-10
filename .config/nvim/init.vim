set smarttab
set nocompatible
set nomodeline
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set backup		" keep a backup file
set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ts=4
set sw=4
set et
set formatoptions+=j
set mouse=a
set number
set numberwidth=5
set viminfo='1000,f1,<500,:1000,/1000
set hlsearch
set backupdir=~/.nvim/backup//
set directory=~/.nvim/swap//
set udf
set udir=~/.nvim/undo//
" Super short timeout for keycode sequences. For local development, 3ms is
" plenty of time to send an escape code, but prevents quick <esc><key> sequences
" from being interpreted as <meta-key>
set ttimeoutlen=3
syntax on

" Clear all autocommands and set a new autocmd group
augroup zach
autocmd!

" set rtp+=~/.nvim/bundle/rust.vim
" set rtp+=~/.nvim/bundle/vim-glsl

" OS X
set rtp+=/usr/local/opt/fzf
" Linux
set rtp+=/usr/share/doc/fzf/examples
set rtp+=~/.nvim/ext/fzf.vim/

" Why aren't these happening in the above bundles?
au BufRead,BufNewFile *.rs set filetype=rust
autocmd! BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set filetype=glsl

" Vundle sesh
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()

"Plugin 'rust-lang/rust.vim'
"Plugin 'Valloric/YouCompleteMe'
"let g:ycm_filetype_blacklist = { 'conque_term': 1 }

"call vundle#end()

filetype plugin indent on
autocmd FileType text setlocal textwidth=78
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

set virtualedit=block

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! Diff vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Folding
set foldminlines=2
set foldopen-=block
autocmd InsertEnter * setlocal foldmethod=manual
autocmd bufread,bufnewfile,InsertLeave * setlocal foldmethod=syntax
autocmd bufread,bufnewfile,InsertLeave *.mg,*.py,*.js,*.jsx,*.html setlocal foldmethod=indent
autocmd FileType dot nmap <C-C> :w<CR>:!dot -Tgtk %<CR>
autocmd FileType python nmap <C-C> :w<CR>:!python %<CR>
autocmd filetype python nmap <Leader>C <C-J>090a#<Esc>==81\|"_Dyy2p<Right><Right>R
autocmd filetype python nmap <Leader>d oimport pdb; pdb.set_trace()<Esc>
autocmd filetype c,cpp nmap <Leader>C <C-J>090a/<Esc>==81\|"_Dyy2p<Right><Right>R
autocmd BufWinEnter * exe "normal zvzz"
autocmd filetype htmldjango,javascript setlocal sw=2 ts=2 fdm=indent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Various key mappings...""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Y - yank rest of line
nmap Y y$
" ! - unhighlight search term
nmap ! :noh<CR>
" zq opens up the function with the line we're in.
nnoremap zq zCzO
" Open up folds when jumping to a line
nmap G GzO
" Insert one character with U (or append with Q, or append at end of line with K
nnoremap <silent> U :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap <silent> Q :exec "normal a".nr2char(getchar())."\e"<CR>
nnoremap <silent> K :exec "normal A".nr2char(getchar())."\e"<CR>
" Ctrl-j/k inserts blank line below/above
nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>j
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>k
" enter inserts a linebreak even in normal mode
nmap <CR>	i<CR><Esc>
" ctrl-i takes remainder of current line and moves it up
nmap <C-I>	"zDO<Esc>"zp==
" break a comment
let g:break_column=119
nmap <C-B> :exec "normal 0".(g:break_column)."lF r\rli\e"<CR>
"nmap <C-B> 0119lF r<CR>li<Esc>
" spacebar toggles folds in normal
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
" Window stuff
map <C-A> <C-W>p
" nmap ˙ <C-W>h
" nmap ∆ <C-W>j
" nmap ˚ <C-W>k
" nmap ¬ <C-W>l
" tmap ˙ <C-W>h
" tmap ∆ <C-W>j
" tmap ˚ <C-W>k
" tmap ¬ <C-W>l
" imap ˙ <Esc><C-W>h
" imap ∆ <Esc><C-W>j
" imap ˚ <Esc><C-W>k
" imap ¬ <Esc><C-W>l
nmap <M-h> <C-W>h
nmap <M-j> <C-W>j
nmap <M-k> <C-W>k
nmap <M-l> <C-W>l
tmap <M-h> <C-W>h
tmap <M-j> <C-W>j
tmap <M-k> <C-W>k
tmap <M-l> <C-W>l
imap <M-h> <Esc><C-W>h
imap <M-j> <Esc><C-W>j
imap <M-k> <Esc><C-W>k
imap <M-l> <Esc><C-W>l
" Window resizing
" XXX flip < and > meaning from vim since my brain seems to think they have it backwards
nmap <M-_> <C-W>-
nmap <M-+> <C-W>+
nmap <M->> <C-W><
nmap <M-<> <C-W>>
nmap <M--> 6<C-W>-
nmap <M-=> 6<C-W>+
nmap <M-,> 6<C-W><
nmap <M-.> 6<C-W>>

nmap <M-i> gT
tmap <M-i> <M-x>gT
imap <M-i> <Esc>gT
nmap <M-o> gt
tmap <M-o> <M-x>gt
imap <M-o> <Esc>gt
nmap <M-p> :tabe<CR>
tmap <M-p> <M-x>:tabe<CR>
imap <M-p> <Esc>:tabe<CR>
nmap <M-S-i> :tabm -<CR>
tmap <M-S-i> <M-x>:tabm -<CR>
imap <M-S-i> <Esc>:tabm -<CR>
nmap <M-S-o> :tabm +<CR>
tmap <M-S-o> <M-x>:tabm +<CR>
imap <M-S-o> <Esc>:tabm +<CR>

" Command line stuff
cnoremap <M-h> <Left>
cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-l> <Right>
cnoremap <S-M-h> <S-Left>
cnoremap <S-M-j> <S-Down>
cnoremap <S-M-k> <S-Up>
cnoremap <S-M-l> <S-Right>

" FZF stuff
nmap <Leader>f :Files<CR>
nmap <Leader>b :History<CR>
"nmap <Leader>t :BTags<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>a :Lines<CR>
nmap <Leader>h :Helptags!<CR>
nmap <Leader>c :History:<CR>
nmap <Leader>/ :History/<CR>

" \w - write file
nmap <Leader>w :w<CR>

"command! SV so ~/.nvimrc
"command! EV e ~/.nvimrc

" Source from plugins--just for script cleanliness
runtime plugin/percent.vim
runtime plugin/substitute.vim

" Terminal shiz
nnoremap <Leader>e :terminal bash -l<CR>

tmap <C-x> <C-\><C-N>
tmap <silent> <M-x> <C-x>:let b:Term_InsertOnEnter=1<CR>
tmap <C-w> <M-x><C-w>
tmap <C-a> <M-x><C-a>
tnoremap <C-v><C-v> <C-v>
tnoremap <C-v><C-w> <C-w>
tnoremap <C-v><C-a> <C-a>
tnoremap <C-v><C-x> <C-x>

let g:terminal_scrollback_buffer_size=100000

let g:Term_NoInsertOnEnter=0

function! TermInsert()
    if exists("b:terminal_job_id")
        if g:Term_NoInsertOnEnter == 0 && (!exists("b:Term_InsertOnEnter") || b:Term_InsertOnEnter == 1)
            startinsert
        endif
        let b:Term_InsertOnEnter=0
        let g:Term_NoInsertOnEnter=0
    endif
endfunction

autocmd BufEnter * call TermInsert()
autocmd TermOpen * setlocal nonumber
nnoremap <silent> <C-Z> :let g:Term_NoInsertOnEnter=1<CR><C-w>t
nnoremap <silent> <C-Q> <C-w>t

" GUI options
set guioptions+=TLlRrBbm
set guioptions-=TLlRrBbm

set guifont=Osaka-Mono:h14

set background=dark
hi Comment ctermfg=Magenta
hi Constant ctermfg=Red
hi Cursor ctermbg=White
hi DiffAdd ctermbg=Blue
hi DiffChange ctermbg=Magenta
hi DiffDelete ctermbg=Cyan
hi Folded ctermfg=Black ctermbg=DarkGray
hi Identifier ctermfg=51
hi LineNr ctermfg=Yellow ctermbg=237
hi MoreMsg ctermfg=Green
hi Normal ctermfg=White ctermbg=Black
hi PreProc ctermfg=Magenta
hi Search ctermfg=Black ctermbg=214
hi Special ctermfg=Red
hi SpecialKey ctermfg=Blue
hi Statement ctermfg=LightGreen gui=NONE
hi StatusLine ctermfg=DarkBlue ctermbg=White
hi StatusLineNC ctermfg=White ctermbg=Black
hi String ctermfg=Red ctermbg=233
hi Todo ctermfg=Black
hi Type ctermfg=Green
hi Underlined ctermfg=Blue
hi Visual ctermfg=Black ctermbg=White
hi lCursor ctermbg=White

" Disable audiovisual bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Ctags baby
set tags=./tags,tags,src/tags

"if filereadable(".vimrclocal")
"	source .vimrclocal
"endif
"
"if filereadable("_vimrclocal")
"	source _vimrclocal
"endif

" " cscope
" if has("cscope")
" 	set csprg=/usr/pkg/bin/cscope
" 	set csto=0
" 	set cst
" 	set nocsverb
" 	" add any database in current directory
" 	if filereadable("cscope.out")
" 		"cs add cscope.out
" 		" else add database pointed to by environment
" 	elseif $CSCOPE_DB != ""
" 		cs add $CSCOPE_DB
" 	endif
" 	set csverb
" endif

" Go back to default autocmd group
augroup end
