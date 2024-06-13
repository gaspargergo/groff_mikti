# MIKTI Groff

Ezzel a programmal az ELTE Magyar Irodalom- és Kultúratudományi intézetének hivatkozási rendszerének(ami [ezen a linken](https://mikti.elte.hu/media/c0/61/34b950bea789fe2548648ad47c8f7548892cf75e13ea2cdafd174fdb16ff/MIKTI_Jegyzetel%C3%A9si%20%C3%BAtmutat%C3%B3.pdf) érhető el) megfelelő dokumentumokat lehet generálni sima textfájlokból.

## Installáció

A program csak Linux rendszereken használható. 

Előfeltétele, hogy a következő programok fel legyenek telepítve:
- groff
- ghostscript
- patch

1. Klónozzuk ezt a git repót:
    git clone https://github.com/gaspargergo/groff_mikti
2. Tegyük futtathatóvá a programot:
    sudo chmod +x groff_mikti/make_pdf.sh

## Használat

A következő fájlok kellenek egy PDf generálásához:
- egy forrásfájl, ami lényegében a szöveg, plusz néhány groff makró
- egy hivatkozási adatbázis

Ha ezek megvannak, csak futtani kell a `make_pdf.sh` nevű scriptet (ami a projekt mappájában található), a hasonló módon:
    make_pdf.sh <forrásfájl path-je> <hivatkozási adatbázis path-je> <kimeneti fájl path-je>

Egyenlőre csak úgy működik minden, hogyha a projekt mappájában van a forrásfájlunk, ez idővel ki lesz javítva
Például, ha a repó mappájában lévő példafájlból akarunk pdf-et generálni, akkor ezt a parancsot kell beütni, miközben a projekt mappájában vagyunk:
    ./make_pdf.sh test.mom references/books.refer document.pdf

### Forrásfájl megírása

Egy groff nevű programot használ ez a projekt a pdf-ek generálásához, ezért a forrásfájlban néhány groff makrót kell alkalmaznunk. Akit érdekel, a projekt a groffon belül is a mom nevű makrócsomagot használja, ennek [ezen a linken](http://www.schaffter.ca/mom/momdoc/toc.html) érhető el a dokumentációja. Szerencsére nem kell sok groff makrót ismerni ahhoz, hogy tudjuk használni írásra.
Amikor a leírásban kacsacsőröket használok, pl így: `<szám>`, akkor ez csak annyit jelent, hogy oda valamit be kell illeszteni, a kacsacsőröket nem kell beírni. 

Az alábbiak a legfontosabb makrók:
**Figyelem!** Fontos, hogy ezek a makrók mindig külön sorra kerüljenek, és mindig ponttal kezdődjenek.

#### Metaadatok

- `.TITLE "<cím>"`
- `.AUTHOR "<szerző>"`
- `.START`

Ezek elég maguktól értetődőek. Minden forrásfájl elején ott kell lennie legalább a .START makrónak.

#### Szöveg írásakor használt makrók

Ezek opcionálisak, annyiszor lehet őket használni, ahányszor kell.

- `.PP`: Ez jelzi minden bekezdés kezdetét.
- `.HEADING <heading száma> "<heading címe>"`: Ezt lehet használni fejezetek, alfejezetek címzéséhez. A számozás egytől indul, ezek a fejezetcímek, a kettes headingek az alfejezetek, stb. stb.
- így kell hivatkozni:
Az előző sor végére rakunk egy `\c`-t, és utána
    .[
        keresőszavak a hivatkozásra (név, cím, bármi)
        (opcionálisan)%P <Ide az oldalszám>
    .]
Ez alapvetően lábjegyzetben készít egy hivatkozást.
- `.FOOTNOTE`: ez jelzi egy lábjegyzet elejét
- `.FOOTNOTE END`: ez jelzi egy lábjegyzet végét
WIP

A `test.mom` nevű fájlban lehet látni egy példát, hogy hogy néz ki egy ilyen forrásfájl.

### Hivatkozási adatbázis megírása

A hivatkozási adatbázisban minden egyes adatbázis különböző fieldekből áll. A hivatkozásokat egy üres sor választja el egymástól. Igazából nincs kötelező field, azokat kell használni, amelyiket szeretnénk, hogy benne legyen a hivatkozásunkban.
Az összes használható field a következő:
- %A (author): szerző 
- %T (title): cím
- %I (issuer): kiadó
- %C (city): kiadás helye
- %D (date): kiadás ideje
- %V (volume): folyóirat évfolyama, könyv kötetszáma
- %N (number): folyóirat füzetszáma
- %P (page): lapszám
- %S (series): sorozat
- %R (record): RMNy/RMK szám (alapvetően azt írja elé a program, hogy RMNy
- %J (journal): folyóirat
- %B (book): tanulmánykötet/válogatáskötet címe
- %b (book author): tanulmánykötet/válogatáskötet szerzője, ha nem az egész könyvet idézzük
- %E (editor): szerkesztő
- %k : szerkesztő helyett más felirat, pl. ford., kiad., előszó, utószó
- %l : fordító (ha van külön szerkesztő is)
- %s (site): weboldal
- %u (url): webes link, url
- %a (access): webes forrás utolsó hozzáférésének dátuma
- %n (note): bármi egyéb megjegyzés, amit a hivatkozás után akarnánk írni

A `references` mappán belül a `books.refer` fájlban lehet látni egy példát ilyen hivatkozási adatbázisra.
