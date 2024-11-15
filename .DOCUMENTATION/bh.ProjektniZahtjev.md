# Projektni zahtjev: Aplikacija za prodaju elektronske opreme

**Kao** administrator prodavnice,  
**želim** upravljati kategorijama, robom, osobinama, fotografijama i narudžbama,  
**kako bih** omogućio posjetiocima i korisnicima efikasno pregledanje i naručivanje robe.  

**Kao** posjetilac aplikacije,  
**želim** pregledati i pretraživati robu po kategorijama i osobinama,  
**kako bih** pronašao željenu robu i potencijalno kreirao korisnički nalog za naručivanje.

**Kao** prijavljeni korisnik,  
**želim** upravljati svojim korisničkim nalogom i narudžbama,  
**kako bih** imao lakši pristup prethodnim kupovinama i mogućnost promjene podataka.

## Funkcionalni zahtjevi:

### Kategorije i osobine
- [ ] Svaka kategorija ima jedinstveni naziv i sliku koja predstavlja robu te kategorije.
- [ ] Kategorije mogu imati neograničen broj potkategorija.
- [ ] Kategorije definišu osobine koje roba u toj kategoriji može imati.
- [ ] Osobine se koriste i kao parametri za pretragu robe.

### Roba
- [ ] Roba pripada samo jednoj kategoriji.
- [ ] Roba ima naziv, kratak opis, detaljan opis, jednu ili više fotografija.
- [ ] Roba ima vrijednosti za jednu ili više osobina kategorije kojoj pripada.
- [ ] Evidencija o promjenama cijena robe mora biti dostupna, a najnovija cijena se prikazuje na web aplikaciji.
- [ ] Povučena roba nije vidljiva u kategorijama i rezultatima pretraga, a stranica te robe preusmjerava korisnika na listing kategorije.

### Početna stranica
- [ ] Prikaz promovisane robe.
- [ ] Prikaz najnovije dodane robe.

### Posjetioci
- [ ] Mogu pregledati robu po kategorijama i pretraživati po osobinama unutar odabrane kategorije.
- [ ] Mogu registrovati korisnički nalog sa obaveznim ličnim podacima, kontaktom, adresom stanovanja i željenim pristupnim parametrima.
- [ ] Prilikom registracije, e-mail mora biti jedinstven.

### Prijavljeni korisnici
- [ ] Mogu dodavati robu u korpu, mijenjati količine ili brisati stavke iz korpe.
- [ ] Mogu naručivati robu iz korpe.
- [ ] Mogu pregledati i mijenjati detalje korisničkog naloga.
- [ ] Imaju pristup listi prethodnih narudžbi i statusima narudžbi.
- [ ] Mogu mijenjati lozinku naloga.

### Administratori
- [ ] Mogu uređivati kategorije, osobine, robu i fotografije.
- [ ] Mogu pregledati narudžbe, mijenjati njihov status (odbijena, prihvaćena, realizovana) i pregledati podatke kupca.

## Tehnička ograničenja:
- [ ] Koristiti relacionu bazu podataka sa ranije usvojenom konvencijom imenovanja.
- [ ] Aplikacija mora biti razvijena na platformi Node.js uz primjenu MVC arhitekture.
- [ ] Grafički korisnički interfejs mora biti prilagodljiv za različite uređaje (*responsive design*).
- [ ] Verzija koda aplikacije mora biti praćena putem Git repozitorija.
- [ ] Primijeniti dobre prakse za razvoj web aplikacija.

#### Napomene:
- Validacija unosa mora biti implementirana gdje je to primjenjivo.
- Obratiti pažnju na sigurnost korisničkih podataka i procesa autentifikacije.
