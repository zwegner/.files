" Percent mappings with count support

function! s:Percent(mode)
    let s:count = v:count1
    if a:mode == 'v'
        normal! gv
    elseif a:mode == 'o'
        normal! v
    endif
    while s:count > 0
        let s:c1 = col('.')
        let s:l1 = line('.')
        normal! %
        let s:c2 = col('.')
        let s:l2 = line('.')
        let s:count -= 1
        if s:count > 0
            " If this was backwards, go forwards
            if s:l2 < s:l1 || s:l1 == s:l2 && s:c2 < s:c1
                normal! %
            endif
            normal! l
        endif
    endwhile
endfunction

vmap <silent> % :<C-U>call <SID>Percent('v')<CR>
nmap <silent> % :<C-U>call <SID>Percent('n')<CR>
omap <silent> % :<C-U>call <SID>Percent('o')<CR>
