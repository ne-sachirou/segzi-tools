<?php
function uOrd($char)
{
    return unpack('N', mb_convert_encoding($char, 'UCS-4BE', 'UTF-8'))[1];
}

foreach (explode(' ', trim(fgets(STDIN))) as $char) {
  $chars[] = '0u'.dechex(uOrd($char));
  $charsOrig[] = '"'.$char.'"';
}
?>#!/usr/bin/env fontforge

Open('NotoSansCJKjp-Regular.otf')
CIDFlatten()
Reencode('unicode')
MergeFonts('migu-1m-regular.ttf')
chars     = [<?php echo implode(',', $chars    ); ?>]
charsOrig = [<?php echo implode(',', $charsOrig); ?>]
i = 0
while (i < SizeOf(chars))
    if (InFont(chars[i]))
        SelectMoreSingletons(chars[i])
    else
        Print("No " + charsOrig[i])
    endif
    ++i
endloop
SelectInvert()
Clear()
SetFontNames('UniSeiJi', 'UniSeiJi', 'UniSeiJi')
SetFondName('UniSeiJi')
SetTTFName(0x409, 1, 'UniSeiJi')
SetTTFName(0x409, 4, 'UniSeiJi')
Generate('uniseiji.ttf')
Close()
