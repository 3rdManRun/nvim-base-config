function! s:auto_mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force || 
        \ input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

augroup AutoEdits
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  autocmd BufWritePost $MYVIMRC,$MYGVIMRC source %
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END
