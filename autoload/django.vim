" Vim plugin for developing with django
" Last Change:	2016 July 16
" Maintainer:	pysnow530 <pysnow530@163.com>
" License:	This file is placed in the public domain.

function! django#runserver(...) abort
    if exists('s:django_server_bufnr')
        echoerr 'Already running at buf #' . s:django_server_bufnr
        return
    endif

    if a:0 >= 2
        let ip = a:0
        let port = a:1
    else
        let ip = g:django_server_ip
        let port = g:django_server_port
    endif

    let cmd = [g:django_python_path, g:django_manager_path, 'runserver',
                \ printf('%s:%s', ip, port)]
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

function! django#makemigrations() abort
    let cmd = [g:django_python_path, g:django_manager_path, 'makemigrations']
    let opts = {}
    call django#utils#termstart(cmd, opts)
endfunction

function! django#sqlmigrate(...) abort
    if a:0 < 2
        if a:0 == 0
            echoerr 'Need app_label and migration_name args!'
        elseif a:0 == 1
            echoerr 'Need migration_name arg!'
        endif
        return -1
    endif

    let app_label = a:1
    let migration_name = a:2
    let cmd = [g:django_python_path, g:django_manager_path, 'sqlmigrate',
                \ app_label, migration_name]
    let opts = {}
    call django#utils#termstart(cmd, opts)

    set ft=sql
endfunction

function! django#migrate() abort
    let cmd = [g:django_python_path, g:django_manager_path, 'migrate']
    let opts = {}
    call django#utils#termstart(cmd, opts)
endfunction

function! django#showmigrations() abort
    let cmd = [g:django_python_path, g:django_manager_path, 'showmigrations']
    let opts = {}
    call django#utils#termstart(cmd, opts)
endfunction

function! django#shell() abort
    let cmd = [g:django_python_path, g:django_manager_path, 'shell']
    let opts = {}
    call django#utils#termstart(cmd, opts)
endfunction
