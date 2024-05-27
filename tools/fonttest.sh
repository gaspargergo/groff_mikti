#!/bin/bash

fontnames="AB ABI AI AR BMB BMBI BMI BMR CB \
CBI CI CR HB HBI HI HNB HNBI HNI HNR HR \
NB NBI NI NR PB PBI PI PR TB TBI TI U-TR \
ZCMI"

testfile=""

for font_family in $fontnames
do
        testfile+="\n.ft $font_family\n$font_family:\nő Ő ű Ű\n.br"
done

echo -e $testfile | groff -K utf8 -Tps
