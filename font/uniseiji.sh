#!/bin/bash

chars=`cat $(dirname $0)/../dic/Unicode舊字JIS舊字對照表.txt | perl -e '$in=join("",<STDIN>);$in=~s/\A---.*\n---\n//ms;print $in' | sed -e 's/#.*$//g' | sed -e '/^\s*$/d' | awk '{print $1}'`
echo $chars | php uniseiji.pe.php > uniseiji.pe
rm uniseiji.ttf 2> /dev/null
fontforge -script uniseiji.pe
