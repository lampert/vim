" Tabs are superior but spaces have more users.
" This remaps <Space> and <BS> to treat leading spaces like tabs when navigating in normal mode.
" Paul Lampert 9/2013

function! SoftTabRight()
    if &softtabstop == 0
        :normal! l
        return
    endif
    let curpos=virtcol(".")-1
    let l=getline(".")
    let llen=len(l)
    if curpos >= llen-1
        :normal! j0
        return
    endif
    let countspace=match(l,"[^ ]")
    if (countspace<0)
        let countspace=llen-1
    endif
    if curpos >= countspace
        :normal! l
        return
    endif
    let rtabstop = curpos / &softtabstop * &softtabstop + &softtabstop
    if (rtabstop > countspace)
        execute ":normal! ".repeat('l',countspace - curpos)
    else
        execute ":normal! ".repeat('l',rtabstop - curpos)
    endif
endfunction

function! SoftTabLeft()
    if &softtabstop == 0
        :normal! 
        return
    endif
    let curpos=virtcol(".")-1
    if curpos == 0
        :normal! 
        return
    endif
    let countspace=match(getline("."),"[^ ]")
    if (countspace<0)
        let countspace=len(getline("."))-1
    endif
    if curpos > countspace
        :normal! 
        return
    endif
    let nmove=curpos % &softtabstop
    if nmove == 0
        execute ":normal! ".repeat('',&softtabstop)
    else
        execute ":normal! ".repeat('',nmove)
    endif
endfunction

:nmap <silent> <C-H> :call SoftTabLeft()
:nmap <silent> <Space> :call SoftTabRight()
