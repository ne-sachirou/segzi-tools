let s:save_cpo = &cpo
set cpo&vim

command! -range=% Seiji <line1>,<line2>call seiji#com_seiji()
command! -range=% Sinji <line1>,<line2>call seiji#com_sinji()

let &cpo = s:save_cpo
unlet s:save_cpo
