function! test#end()
  if len(v:errors) > 0
    call writefile(v:errors, 'test/errors.log')
    cquit!
  else
    quit!
  endif
endfunction
