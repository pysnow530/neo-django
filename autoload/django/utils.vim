" Vim plugin for developing with django
" Last Change:	2016 July 16
" Maintainer:	pysnow530 <pysnow530@163.com>
" License:	This file is placed in the public domain.

function! django#utils#termstart(cmd, opts) abort
    if !exists('*termopen')
        exe '!' join(map(a:cmd, 'shellescape(v:val)'), ' ')
        return 0
    endif

    let height = get(a:opts, 'height', 0)
    let bufpersist = get(a:opts, 'bufpersist', 0)

    exe (height > 0 ? height : '') . 'new'
    call termopen(a:cmd, a:opts)
    exe 'set' 'bufhidden=' . (bufpersist ? 'hide' : 'wipe')

    let bufnr = bufnr('%')

    return bufnr
endfunction
