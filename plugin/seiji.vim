let s:save_cpo = &cpo
set cpo&vim

command! -range=% Seiji <line1>,<line2>call seiji#conv_to_seiji()
command! -range=% Zokuji <line1>,<line2>call seiji#conv_to_zokuji()

let &cpo = s:save_cpo
unlet s:save_cpo