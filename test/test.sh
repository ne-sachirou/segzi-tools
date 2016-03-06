#!/bin/bash
if [ -z "$VIM" ]; then
  VIM='vim'
fi
: > test/errors.log
for testfile in $(ls test/*.vim); do
  $VIM -u test/.vimrc -U NONE -f -c "source test/lib/test.vim | source $testfile"
done
if [ -s test/errors.log ]; then
  >&2 cat test/errors.log
  exit 1
fi
