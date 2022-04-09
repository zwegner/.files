set smarttab
set nocompatible
set nomodeline
set nojoinspaces
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
set relativenumber
set number
set numberwidth=5
set noequalalways
set hlsearch
set viminfo='1000,f1,<500,:1000,/1000
set backupdir=~/.nvim/backup//
set directory=~/.nvim/swap//
set udf
set udir=~/.nvim/undo//
set virtualedit=block
" Super short timeout for keycode sequences. For local development, 3ms is
" plenty of time to send an escape code, but prevents quick <esc><key> sequences
" from being interpreted as <meta-key>
set ttimeoutlen=3
syntax on

mapclear
mapclear!
tmapclear

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

" Disable fucking annoying Python indenting
let g:pyindent_disable_parentheses_indenting=1

filetype plugin indent on
autocmd FileType text setlocal textwidth=78
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! Diff vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

function! SendRunCmd(ctrlc)
    if a:ctrlc
        let @r = "\<C-C>\r\e[A\r"
    else
        let @r = "\e[A\r"
    endif
    noautocmd wincmd t
    normal G
    put r
    noautocmd wincmd p
endfunction

nmap <Leader>r :update<CR>:call SendRunCmd(0)<CR>
nmap <Leader>R :update<CR>:call SendRunCmd(1)<CR>

" Folding
set foldminlines=2
set foldopen-=block

" Autocmds for filetype-based stuff
autocmd bufread,bufnewfile *.mg,*.py,*.js,*.jsx,*.html,*.lua setlocal foldmethod=indent
autocmd FileType dot nmap <buffer> <C-C> :update<CR>:!dot -Tgtk %<CR>
"autocmd FileType python nmap <buffer> <C-C> :update<CR>:!python3 %<CR>
autocmd filetype python nmap <buffer> <Leader>C <C-J>090a#<Esc>==81\|"_Dyy2p<Right><Right>R
autocmd filetype python nmap <buffer> <Leader>d oimport pdb; pdb.set_trace()<Esc>
autocmd filetype c,cpp nmap <buffer> <Leader>C <C-J>090a/<Esc>==81\|"_Dyy2p<Right><Right>R
autocmd filetype lua nmap <buffer> <Leader>C <C-J>090a-<Esc>==81\|"_Dyy2p<Right><Right>R
autocmd BufWinEnter * exe "normal zvzz"
autocmd filetype htmldjango,javascript setlocal sw=2 ts=2 fdm=indent

" C-C in terminal enters and kills cuz I do it a million times a day
autocmd TermOpen * nnoremap <buffer> <C-C> i<C-C>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Various key mappings...""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Y - yank rest of line
nmap Y y$
" ! - unhighlight search term
nmap ! :noh<CR>
" zq opens up the function with the line we're in.
nnoremap zq zCzO
" Double C-R for inserting default register
cnoremap <C-R><C-R> <C-R>"
inoremap <C-R><C-R> <C-R>"
" Open up folds when jumping to a line
nnoremap <silent> G G@=(foldlevel('.')?'zo':'')<CR>
" M-BS for Del
inoremap <M-BS>  <Del>
cnoremap <M-BS>  <Del>
nnoremap <M-BS>  i<Del><Esc>
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
let g:break_column=81
nmap <C-B> :exec "normal 0".(g:break_column)."lF r\rli\e"<CR>
" spacebar toggles folds in normal
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>

" quick changelist jumps
nnoremap <silent> <M-;> g;
nnoremap <silent> <M-,> g,

" Undo tree navigation
nnoremap <silent> <M-b> :earlier<CR>
nnoremap <silent> <M-n> :later<CR>

" Window stuff
map <C-A> <C-W>p
nnoremap <C-n> <C-W>w
nnoremap <C-p> <C-W>W
"tnoremap <C-n> <C-W>w
"tnoremap <C-p> <C-W>W

nmap <M-h> <C-W>h
nmap <M-j> <C-W>j
nmap <M-k> <C-W>k
nmap <M-l> <C-W>l
tmap <M-h> <M-x><C-W>h
tmap <M-j> <M-x><C-W>j
tmap <M-k> <M-x><C-W>k
tmap <M-l> <M-x><C-W>l
imap <M-h> <Esc><C-W>h
imap <M-j> <Esc><C-W>j
imap <M-k> <Esc><C-W>k
imap <M-l> <Esc><C-W>l
" Window resizing
nnoremap <M-_> <C-W>-
nnoremap <M-+> <C-W>+
nnoremap <M-{> <C-W><
nnoremap <M-}> <C-W>>
nnoremap <M--> 12<C-W>-
nnoremap <M-=> 12<C-W>+
nnoremap <M-[> 12<C-W><
nnoremap <M-]> 12<C-W>>

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

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
" FZF stuff
nnoremap <Leader>F :GFiles<CR>
nnoremap <Leader>f :Files<CR>
nmap <Leader>b :History<CR>
"nmap <Leader>t :BTags<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>a :Lines<CR>
nmap <Leader>h :Helptags!<CR>
nmap <Leader>c :History:<CR>
nmap <Leader>/ :History/<CR>
nmap <Leader>g :Rg<CR>

command! -bang -nargs=* PyGrep :call fzf#vim#grep("rg --no-ignore-vcs --column --line-number --no-heading --color=always --smart-case " .shellescape(<q-args>), 1, {'dir': '~/doc/python-3.8.1-docs-text/library'}, <bang>0)
nmap <Leader>p :PyGrep<CR>

" \w - write file, etc
nmap <unique> <Leader>w :w<CR>
nmap <unique> <Leader>q :q<CR>
nmap <unique> <Leader>e :e<CR>

command! SV so ~/.config/nvim/init.vim
command! EV e ~/.config/nvim/init.vim

" Source from plugins--just for script cleanliness
runtime plugin/percent.vim
runtime plugin/substitute.vim

" Terminal shiz
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
autocmd TermOpen * setlocal nonumber nornu

nnoremap <unique> <Leader>t :terminal bash -l<CR>

tnoremap <unique> <C-x> <C-\><C-N>
tmap <unique> <C-w> <M-x><C-w>
tmap <unique> <C-a> <M-x><C-a>
tmap <unique> <C-q> <M-x><C-q>
tnoremap <unique> <silent> <M-x> <C-\><C-N>:let b:Term_InsertOnEnter=1<CR>
tnoremap <unique> <C-v><C-v> <C-v>
tnoremap <unique> <C-v><C-w> <C-w>
tnoremap <unique> <C-v><C-a> <C-a>
tnoremap <unique> <C-v><C-x> <C-x>
nnoremap <unique> <C-Q> <C-w>t
nnoremap <unique> <silent> <C-Z> :let g:Term_NoInsertOnEnter=1<CR><C-w>t

set background=dark
hi Normal ctermfg=White ctermbg=Black
"highlight NormalNC ctermbg=233

hi Comment ctermfg=69
hi Constant ctermfg=Red
hi Cursor ctermbg=White
hi DiffAdd ctermbg=Blue
hi DiffChange ctermbg=Magenta
hi DiffDelete ctermbg=Cyan
hi Folded ctermfg=Black ctermbg=DarkGray
hi Identifier ctermfg=51
hi LineNr ctermfg=Yellow ctermbg=237
hi MoreMsg ctermfg=Green
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

" Go back to default autocmd group
augroup end
