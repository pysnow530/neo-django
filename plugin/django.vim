" Vim plugin for developing with django
" Last Change:	2016 July 16
" Maintainer:	pysnow530 <pysnow530@163.com>
" License:	This file is placed in the public domain.

" {{{ header
if &cp && exists("g:loaded_django")
    finish
endif
let g:loaded_django = 1
" }}}

" {{{ init
function! s:init_var(name, val) abort
    if !exists(a:name)
        if type(a:val)
            exe 'let' a:name '=' string(a:val)
        else
            exe 'let' a:name '=' a:val
        endif
    endif
endfunction

call s:init_var('g:django_python_path', 'python')
call s:init_var('g:django_manager_path', 'manage.py')
call s:init_var('g:django_server_ip', '127.0.0.1')
call s:init_var('g:django_server_port', '8000')
" }}}

" {{{ commands
command! DjangoRunserver call django#runserver(<f-args>)
command! DjangoKillserver call django#killserver()
command! DjangoToggleServerBuf call django#toggle_server_buf()
command! DjangoMakemigrations call django#makemigrations()
command! -nargs=* DjangoSqlmigrate call django#sqlmigrate(<f-args>)
command! DjangoMigrate call django#migrate()
command! DjangoShowmigrations call django#showmigrations()
command! DjangoShell call django#shell()
" }}}
