" Vim plugin for developing with django
" Last Change:	2016 July 16
" Maintainer:	pysnow530 <pysnow530@163.com>
" License:	This file is placed in the public domain.

function! django#runserver() abort
    if exists('s:django_server_bufnr')
        echoerr 'Already running at buf #' . s:django_server_bufnr
        return
    endif

    let cmd = [g:django_python_path, g:django_manager_path, 'runserver']
    let opts = {'bufpersist': 1}
    let bufnr = django#utils#termstart(cmd, opts)
    let s:django_server_bufnr = bufnr
endfunction

function! django#killserver() abort
    if !exists('s:django_server_bufnr')
        echoerr 'Server is not running!'
        return
    endif

    exe s:django_server_bufnr 'bdelete!'
    unlet s:django_server_bufnr
    echo 'killed!'
endfunction

function! django#toggle_server_buf() abort
    if !exists('s:django_server_bufnr')
        echoerr 'Server is not running!'
        return
    endif

    let winnr = bufwinnr(s:django_server_bufnr)
    if winnr != -1
        exe winnr 'q'
        exe winnr 'wincmd' 'w'
    else
        exe 'new' '#'.s:django_server_bufnr
    endif
endfunction
