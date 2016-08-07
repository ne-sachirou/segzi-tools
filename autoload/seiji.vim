let s:save_cpo = &cpo
set cpo&vim

let s:script_file     = expand('<sfile>:p:h')
let s:translation_dic = ['', '']
let s:proposition_dic = {}

function! seiji#com_seiji() range
  let view = winsaveview()
  for lnum in range(a:firstline, a:lastline)
    call s:translate_to_seiji(lnum)
    call s:propose_to_seiji(lnum)
  endfor
  call winrestview(view)
endfunction

function! seiji#com_sinji() range
  let view = winsaveview()
  for lnum in range(a:firstline, a:lastline)
    call s:translate_to_zokuji(lnum)
  endfor
  call winrestview(view)
endfunction

function! s:init()
  for line in readfile(s:script_file . '/../dictionary/translation.dic')
    let dic_item = split(line, ' ')
    let s:translation_dic[0] .= dic_item[0]
    let s:translation_dic[1] .= dic_item[1]
  endfor
  for line in readfile(s:script_file . '/../dictionary/proposition.dic')
    let dic_item = split(line, ' ')
    let s:proposition_dic[dic_item[0]] = dic_item[1 :]
  endfor
endfunction

function! s:translate_to_seiji(lnum)
  let line = getline(a:lnum)
  let line = tr(line, s:translation_dic[0], s:translation_dic[1])
  call setline(a:lnum, line)
endfunction

function! s:propose_to_seiji(lnum)
  let line = split(getline(a:lnum), '\zs')
  for idx in range(0, len(line) - 1)
    if !has_key(s:proposition_dic, line[idx])
      continue
    endif
    let seijis = s:proposition_dic[line[idx]]
    let prompt = join(line, '') . "\n"
    for jdx in range(0, len(seijis) - 1)
      let prompt .= (jdx + 1) . ' ' . seijis[jdx] . "\n"
    endfor
    let prompt .= '? '
    let choise = 0
    while choise < 1 || len(seijis) < choise
      let choise = input(prompt) - 0
      echo "\n"
    endwhile
    let line[idx] = seijis[choise - 1]
  endfor
  call setline(a:lnum, join(line, ''))
endfunction

function! s:translate_to_zokuji(lnum)
  let line = getline(a:lnum)
  for [zokuji, seijis] in items(s:proposition_dic)
    let line = substitute(line, join(seijis, '\|'), zokuji, 'g')
  endfor
  let line = tr(line, s:translation_dic[1], s:translation_dic[0])
  call setline(a:lnum, line)
endfunction

call s:init()

let &cpo = s:save_cpo
unlet s:save_cpo
