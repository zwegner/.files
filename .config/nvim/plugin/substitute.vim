" S - replace current word with pasted text.
function! s:Substitute(mode)
    if a:mode == 'n'
        normal! viw
    endif

    let s:at_end = col("'>") == col("$") - 1

    normal! gv"_d

    if s:at_end
        normal p
    else
        normal P
    endif
endfunction

nmap S :call <SID>Substitute('n')<CR>
vmap S :<C-U>call <SID>Substitute('v')<CR>
