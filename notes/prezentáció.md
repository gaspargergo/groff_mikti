# Alternatív szövegkészítés

1. Miért?

## Kompatibilitás
    - régi hardverrel (mi van, ha elromlik a kép, és csak egy régi laptop áll rendelkezésre?)
    - új hardverrel (telefonon is akár)
    - gyorsaság (legalábbis a wordnél gyorsabb)
    - plaintext file-t minden rendszer tud olvasni
    - hozni képet arról, hogy mennyi a memóriahasználata minden programnak

## Szövegkompozíció és tördelés szétválasztása
    - számomra ez nem olyan fontos
    - valakinek segíthet fókuszálni
    - a szöveg struktúrájának egyértelmű jelzései (Wordben nem lehet egyből megmondani, hogy valami alcímnek néz ki, vagy alcím is)

## Mozgástér
    - Mi van, ha új word verzió van, ami csak az új Windowson fut, és ahhoz egy új gép kell?
    - Mi történik a wordben?
    - Ingyenes!

2. Alternatívák
- három különböző "nehézségi fokozat"

## Pofonegyszerű - Libreoffice
    - drop-in replacement
    - nagy program, de több mindenen fut
    - sokféle formátumot ismer, mostani és régi Word fileok is
    - kicsit máshogy néznek ki benne a dolgok néha

## Eggyel nehezebb - Markdown+Pandoc
    - Könnyen olvasható, intuitív
    - könnyű a setup
    - ehhez is kell külön .bib fájl, meg .ics az idézetekhez
    - ha valami baj van, mindig át lehet rakni .docx formátumba

## The big guns - LaTeX és Groff
    - Bonyolultabb setup és használat
    - de! Groffban "már" megcsináltam az egészet, ezért ha az ember nem akar belenyúlni, nem kell
    - Totális kontroll, mindent be lehet pontosan úgy állítani, ahogy akarjuk
    - Latexet talán lehet pandoccal is használni, tehát át lehet .docx-be is fordítani
