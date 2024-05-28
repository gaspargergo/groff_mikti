ToDo:
- megkönnyíteni a hivatkozások használatát
     - ne kelljen kiírni, hogy ref
     - ne legyen utána egy sor whitespace
    - ne kelljen elé \c
    - legjobb lenne inline, de ez nem szükséges szerintem, meg nagyon bonyolítja is a dolgokat föloslegesen

- Működjön rendesen az ő, Ő, ű, Ű
     - és a kiskapitális hogyan, hogyha nincs külön kiskapitális font? Mert nincs hozzá escape sequence
     - írni kéne egyet hozzá? Végül is, ha más nem, lehet esztimálni egy uppercase-sel meg egy font méret váltással (az első betűnél is?)
    - miért rossz az uő az irodalomjegyzékben?
    - tesztelni, hogy van-e U-T font, ha nem, akkor kell csak workaround

- megcsinálni, hogy a TITLE egy start utáni macro legyen, mondjuk HEADING 1-ből
    - Lehet, hogy néhány metadatát érdemes a Userre hagyni, pl. title és author, mert kellhet a dologhoz

- script, ami bib formátumból átkonvertálja a bibliográfiai adatbázist refer által használható formátumba
    - seddel ez talán nem egy nehéz feladat

- Egybe a cím és szerző, ha a cím elején ott van a szerző neve(ezt lehet, hogy inkább magában az adatbázisban kéne megoldani? Nem tudom, mert minimalizálni kéne az adatbázison belüli manipulációt, hogy automatizálható lehessen, és egyszerűbb legyen, hogy csak a forrásfájllal kell foglalkozni)
    - valahogy a length+substring etc
    - vagy, odatenni egy pontot az autor neve végére, és ezzel jelezni, hogy egyben van, de ez nem a legideálisabb, eléggé bezavar a dolgokba

- ki kell cserélni esetleg a sima dash-eket az évszámokban en-dashekre(\[en])

- hogyan tudnánk abc sorrendbe rakni az irodalomjegyzéket? esetleg k alapján rendezni?

- Írni valami használati útmutatót
    - Idézett mű és címrövidítések nem fognak automatikusan működni

- vim refer adatbázis filetype plugin

- Megnézni, milyen a licensze a mom-nak, feltüntetni, hogy felhasználtam a kódot
    - licenszet rakni magára a projektre is

DONE:
- egy header, amit mindig betesz a fájlok elejére, hogy ne kelljen azzal szöszölni(hiszen nem igen változik a formattálás az itk-ban
- Uo+pp, ha az előző mű
- script, ami végigmegy egyesével az authorokon a refer adatbázisban, és megkérdezi, hogy a név melyik része legyen kiskapitálisban, abba teszi őket
    - plusz még formattálja a karaktereket is, hogy az ő-k,ű-k, stb.-k használhatóak legyenek (ehhez lehet, hogy elég egy preformatter is)
    - Ezt preconvval simán meg lehet oldani, csak utána valahogy egy másik fájlba kéne rakni a dolgokat, ami a formattált bibliográfiai adatbázis
    - Gondolni kéne arra is, hogy lehet, hogy az A fieldben több név van, tehát jó lenne több mindent is tudni kiválasztani
        - Jó lenne, ha szubszekvens formattálásoknál nem kéne az összesen átmenni, hanem csak azokon, amiken addig még nem, kéne valami "merge" funkció bele
        - ezeket a fieldeket kell nézni: %A, %E, %l, talán %b
- script, ami mindezeket összehangolja + wrapper a pdfmom-hoz
