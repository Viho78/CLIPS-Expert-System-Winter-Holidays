(defrule tak
	=>
	(assert (tak tak))
)
(defrule nie
	=>
	(assert (nie nie))
)
(defrule plaza
	=>
	(assert (plaza plaza))
)
(defrule gory
	=>
	(assert (gory gory))
)
(defrule miasto
	=>
	(assert (miasto miasto))
)
(defrule cena1
	=>
	(assert (cena1 1))
)
(defrule cena2
	=>
	(assert (cena2 2))
)
(defrule cena3
	=>
	(assert (cena3 3))
)
(defrule cena4
	=>
	(assert (cena4 4))
)

;wiadomosc poczatkowa
(defrule start
  	(declare (salience 500))
  	=>
  	(printout t "Wybierz miejsce swoich wakacji zimowych! " crlf)
	(printout t "Wystarczy, ze bedziesz odpowiadac na pytania odpowiedziami z nawiasow na koncu kazdego pytania." crlf)
  	(printout t "Zaczynajmy." crlf)
	(printout t "" crlf)
  	(assert (print-list list))
)

;pytanie i opis o 'cieplo'
(defrule cieplo
   	?print <- (print-list list)
	(tak ?tak)
	(nie ?nie)
   	=>
   	(printout t "Czy chcesz aby miejsce wakacji bylo cieple? (przeciwienstwem sa wakacje w zimnym miejscu)." crlf)
	(printout t "Wybranie cieplych wakacji oznacza rezygnacje z wakacji w Polsce, poniewaz jest tam zimno. " crlf)
	(printout t "Pojecie cieple oznacza ponad 10 stopni Celcjusza (srednia temperatura miejsca w okresie zimowym)." crlf)
	(printout t "Czy ma byc cieplo?: (tak/nie) ?" crlf)
   	(assert (cieplo =(read)))
)

;sprawdzenie odpowiedzi do 'cieplo'
(defrule test1
	(cieplo ?cieplo)
	(tak ?tak)
	(nie ?nie)
	=>
	(if(or(eq ?cieplo ?tak)(eq ?cieplo ?nie))
		then 
		(printout t "Dobra odpowiedz!" crlf)
		(printout t "" crlf)
		else 
		(printout t "Odpowiedz nie pasuje, program sie wylaczy..." crlf)
		(halt)			
	)
)

;pytanie i opis do 'polska'
(defrule polska1
	(cieplo nie)
	(tak ?tak)
	(nie ?nie)
	=>
	(printout t "Czy chcesz aby miejscem twojego wyjazdu byla Polska? (przeciwienstwem jest miejsce poza Polska)" crlf)
	(printout t "Wybranie wakacji w Polsce jednoczesnie zwalnia nas z pytania o miejsce wakacji w europie, poniewaz polska jest w Europie." crlf)
	(printout t "Czy wyjazd ma byc w Polsce : (tak/nie) ?" crlf)
   	(assert (polska =(read)))
)

;sprawdzenie odpowiedzi do 'polska'
(defrule test2
	(cieplo nie)
	(polska ?polska)
	(tak ?tak)
	(nie ?nie)
	=>
	(if(or(eq ?polska ?tak)(eq ?polska ?nie))
		then (printout t "Dobra odpowiedz!" crlf)
		(printout t "" crlf)
		else (printout t "Odpowiedz nie pasuje, program sie wylaczy..." crlf)
		(halt)			
	)
)

;jesli ma byc cieplo to nie moze byc w polsce
(defrule polska2
	(cieplo tak)
	=>
	(assert (polska brak))
)

;pytanie i opis do 'aktywnie'
(defrule aktywnie
	(tak ?tak)
	(nie ?nie)
  	=>
	(printout t "Czy na miejscu maja byc opcje spedzania wakacji aktywnie? (przeciwienstwem jest miejsce z brakiem aktywnych atrakcji lub miejsce z nieobowiazkowymi aktywnosciami)" crlf)
	(printout t "Aktywne atrakcje rozumiemy jako uprawianie sportow, mozliwosci dlugich wycieczek i zwiedzania, sportowe atrakcje hotelowe" crlf)
  	(printout t "Czy ma byc aktywnie : (tak/nie)?" crlf)
  	(assert (aktywnie =(read)))
)

;sprawdzenie odpowiedzi do 'aktywnie'
(defrule test3
	(aktywnie ?aktywnie)
	(tak ?tak)
	(nie ?nie)
	=>
	(if(or(eq ?aktywnie ?tak)(eq ?aktywnie ?nie))
		then (printout t "Dobra odpowiedz!" crlf)
		(printout t "" crlf)
		else (printout t "Odpowiedz nie pasuje, program sie wylaczy..." crlf)
		(halt)			
	)
)

;pytanie i opis do 'miejsce'
(defrule miejsce
	(miasto ?miasto)
	(plaza ?plaza)
	(gory ?gory)
  	=>
	(printout t "Wybierz miejsce miejsce dominujace podczas wybranych wakacji zimowych." crlf)
	(printout t "Glownymi miejscami sa plaza, gory lub miasto. Wybranie jednego z nich nie wyklucza obecnosci pozostalych, gwarantuje ze bedzie to miejsce dominujace na wyjezdzie." crlf)
	(printout t "(przy wyborze opcji 'gory' oraz opcji 'cieple' w wczesniejszym pytaniu musimy liczyc sie z tym ze " crlf)
	(printout t "gory beda w cieplym obszarze, ale w gorach juz raczej nie bedzie cieplo ze wzgledu na roznice wysokosci)" crlf)
  	(printout t "Wybierz miejsce przewodnie : (plaza/gory/miasto)?" crlf)
  	(assert (miejsce =(read)))
)

;sprawdzenie odpowiedzi do 'miejsce'
(defrule test4
	(miejsce ?miejsce)
	(miasto ?miasto)
	(plaza ?plaza)
	(gory ?gory)
	=>
	(if(or(eq ?miejsce ?plaza)(eq ?miejsce ?gory)(eq ?miejsce ?miasto))
		then (printout t "Dobra odpowiedz!" crlf)
		(printout t "" crlf)
		else (printout t "Odpowiedz nie pasuje, program sie wylaczy..." crlf)
		(halt)			
	)
)

;pytanie i opis do 'eu'
(defrule eu
	(or(polska nie)(polska brak))
	(tak ?tak)
	(nie ?nie)
  	=>
	(printout t "Czy miejsce wakacji ma znajdowac sie w Europie? (przeciwienstwem jest miejsce wakacji poza Europa)" crlf)
  	(printout t "Czy miejscem wakacji ma byc Europa? : (tak/nie)?" crlf)
  	(assert (eu =(read)))
)

;sprawdzenie odpowiedzi do 'eu'
(defrule test5
	(or(polska nie)(polska brak))
	(eu ?eu)
	(tak ?tak)
	(nie ?nie)
	=>
	(if(or(eq ?eu ?tak)(eq ?eu ?nie))
		then (printout t "Dobra odpowiedz!" crlf)
		(printout t "" crlf)
		else (printout t "Odpowiedz nie pasuje, program sie wylaczy..." crlf)	
		(halt)		
	)
)

;pytanie i opis do 'przedzial cen'
(defrule przedzial_cen
	(cena1 ?cena1)
	(cena2 ?cena2)
	(cena3 ?cena3)
	(cena4 ?cena4)
  	=>
  	(printout t "Wybierz przedzial cenowy wycieczki. Ceny okreslone sa dla 7 dniowego wypoczynku jednej osoby oraz przelot w dwie strony." crlf)
	(printout t "Cena nie zawiera dodatkowych oplat zwiazanych z np. wiza, posilkami itp." crlf)
	(printout t "Cena danego miejsca jest okreslona dla najtanszego hotelu w danym miejscu ktory posiada co najmniej 3 gwiazdki oraz jest dobrze oceniany w serwisach internetowych." crlf)
	(printout t "Ceny (szczegolnie 3 i 4 przedzial) nie oznaczaja ze w dane miejsce nie da sie pojechac taniej bo zwykle sie da," crlf) 
	(printout t "ale jesli chcesz wydac na wyjazd sume pieniedzy z danego przedzialu to proponowane miejsce bedzie do tego dobre (wiecej udogodnien i luksusu)." crlf)
	(printout t "Przedzialy: do 2000 zl | do 4000 zl | do 8000 zl | do 16000 zl" crlf)
	(printout t "Wybierz: (1/2/3/4)?" crlf)
  	(assert (przedzial_cen =(read)))
)

;sprawdzenie odpowiedzi do 'przedzial cen'
(defrule test6
	(przedzial_cen ?przedzial_cen)
	(cena1 ?cena1)
	(cena2 ?cena2)
	(cena3 ?cena3)
	(cena4 ?cena4)
	=>
	(if(or(eq ?przedzial_cen ?cena1)(eq ?przedzial_cen ?cena2)(eq ?przedzial_cen ?cena3)(eq ?przedzial_cen ?cena4))
		then (printout t "Dobra odpowiedz!" crlf)
		(printout t "" crlf)
		else (printout t "Odpowiedz nie pasuje, program sie wylaczy..." crlf)	
		(halt)		
	)
)



;Definicje miejsc;;;;;;;;;;;;;;;;;;;;;;;
(defrule CostaDelSol
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to wybrzeze Costa del Sol w Hiszpanii" crlf)
)
(defrule GranCanaria
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to wyspa Gran Canaria w Hiszpanii" crlf)
)
(defrule Tenerifa
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to wyspa Tenerifa w Hiszpanii" crlf)
)
(defrule Sycylia
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Sycylia we Włoszech" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule Monastyr
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Monastyr w Tunezji" crlf)
)
(defrule Fujairah
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Fujairah w Zjednoczonych Emiratach Arabskich" crlf)
)
(defrule Galu
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Galu w Kenii" crlf)
)
(defrule Cancun
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Cancun w Meksykanskich Stanach Zjednoczonych" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;
(defrule Kreta
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to gory Kreta w Grecji" crlf)
)
(defrule RodopyIPirin
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to gory Rodopy i Pirin w Bułgarii" crlf)
)
(defrule SerraDaEstrela
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to gory Serra da Estrela w Portugalii" crlf)
)
(defrule Pireneje
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to gory Pireneje w Hiszpanii" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;
(defrule Taurus
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to gory Taurus w Turcji" crlf)
)
(defrule Algier
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to gory Algier w Algerii" crlf)
)
(defrule Batian
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to gory Batian w Kenii" crlf)
)
(defrule GKosciuszki
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Gora Kosciuszki w Australii" crlf)
)
;;;;;;;;;;;;;;;;;;;
(defrule Split
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to miasto Split w Chorwacji" crlf)
)
(defrule Barcelona
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to miasto Barcelona w Hiszpanii" crlf)
)
(defrule Rzym
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to miasto Rzym we Włoszech" crlf)
)
(defrule Palermo
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to miasto Palermo we Włoszech" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;
(defrule Kari
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to miasto Kair w Egipcie" crlf)
)
(defrule Casablanca
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to miasto Casablanca w Maroku" crlf)
)
(defrule Miami
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to miasto Miami w USA" crlf)
)
(defrule Sydney
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to miasto Sydney w Australii" crlf)
)
;;;;;;;;;;;;;;;;;
(defrule Dures
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Dures w Albanii" crlf)
)
(defrule Warna
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Warna w Bułgarii" crlf)
)
(defrule Zakyntos
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Zakyntos w Grecjii" crlf)
)
(defrule Sycylia2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Sycylia we Włoszech" crlf)
)
;;;;;;;;;;;;;;;;;;;
(defrule Tunis
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Tunis w Tunezji" crlf)
)
(defrule SriLanka
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Sri Lanka w Indiach" crlf)
)
(defrule Zanzibar
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Zanzibar w Kenii" crlf)
)
(defrule Karaiby
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Dominikana na Karaibach" crlf)
)
;;;;;;;;;;;;;;;
(defrule Kreta2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to gory na Krecie w Grecji" crlf)
)
(defrule Pireneje2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to gory Pireneje w Hiszpanii" crlf)
)
(defrule SierraDaEstrela2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to gory Serra Da Estrela w Portugalii" crlf)
)
(defrule Alpy
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to gory Alpy w Szwajcarii" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule Taurus2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to gory Taurus w Turcji" crlf)
)
(defrule Algier2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to gory Algier w Algerii" crlf)
)
(defrule Batian2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to gory Batian w Kanii" crlf)
)
(defrule GoraKosciuszki2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Gora Kosciuszki w Asutralii" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;;
(defrule Split2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to miasto Split w Chorwacji" crlf)
)
(defrule Rzym2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to miasto Rzym we Włoszech" crlf)
)
(defrule Ateny
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to miasto Ateny w Grecji" crlf)
)
(defrule Barcelona2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to miasto Barcelona w Hiszpanii" crlf)
)
;;;;;;;;;;;;
(defrule Tunis2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to miasto Tunis w Tunezji" crlf)
)
(defrule Dubaj
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to miasto Dubaj w Zjednoczonych Emiratach Arabskich" crlf)
)
(defrule LosAngeles
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to miasto Los Angeles w USA" crlf)
)
(defrule Sydney2
	(cieplo tak)
	(polska brak)
	(aktywnie nie)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to miasto Sydney w Australii" crlf)
)
;;;;;;;;;;;;;;;
(defrule Mielno
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce plaza)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to plaza w Mielnie w Polsce" crlf)
)
(defrule Łeba
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce plaza)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to plaza w Łebie w Polsce" crlf)
)
(defrule Kołobrzeg
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce plaza)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to plaza w Kołobrzegu w Polsce" crlf)
)
(defrule Władysławowo
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce plaza)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to plaza w Władysławowie w Polsce" crlf)
)
;;;;;;;;;;;;;;;;;;
(defrule GorySowie
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce gory)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Gory Sowie w Polsce" crlf)
)
(defrule MasywSniezka
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce gory)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to gory Masyw Sniezka w Polsce" crlf)
)
(defrule BeskidZywiecki
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce gory)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to gory Beskid Zywiecki w Polsce" crlf)
)
(defrule Tatry
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce gory)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to gory Tatry w Polsce" crlf)
)
;;;;;;;;;;;;;;;;;
(defrule Gdansk
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce miasto)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to miasto Gdansk w Polsce" crlf)
)
(defrule Wroclaw
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce miasto)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to miasto Wroclaw w Polsce" crlf)
)
(defrule Krakow
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce miasto)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to miasto Krakow w Polsce" crlf)
)
(defrule Warszawa
	(cieplo nie)
	(polska tak)
	(aktywnie tak)
	(miejsce miasto)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to miasto Warszawa w Polsce" crlf)
)
;;;;;;;;;;;;;
(defrule Romo
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Romo w Danii" crlf)
)
(defrule OmahaBeach
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Omaha Beach w Francji" crlf)
)
(defrule Pula
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Pula w Chorwacji"crlf)
)
(defrule RefviksandenBeach
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Refviksanden Beach w Norwegii" crlf)
)
;;;;;;;;;;;;;;
(defrule Tatry2
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to gory Tatry w Slowacji" crlf)
)
(defrule Lom
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to gory Lom w Norwegii" crlf)
)
(defrule Are
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to gory Are w Szwecji" crlf)
)
(defrule Alpy2
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to gory Alpy w Austrii" crlf)
)
;;;;;;;;;;;;;;;;;;;;;
(defrule Wieden
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to miasto Wieden w Austrii" crlf)
)
(defrule Sztokholm
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to miasto Sztokholm w Szwecji" crlf)
)
(defrule Zurych
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to miasto Zurych w Szwecji" crlf)
)
(defrule Londyn
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce miasto)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to miasto Londyn w Wielkiej Brytanii" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule Reynishverfi
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Reynishverfi na Islandii" crlf)
)
(defrule Batumi
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Batumi w Gruzji" crlf)
)
(defrule Wladywostok
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Szlana Plaza w Wladywostoku w Rosji" crlf)
)
(defrule Ontario
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Ontario w Kanadzie" crlf)
)
;;;;;;;;;;;;;;;;;;;
(defrule Taurus3
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to gory Taurus w Turcji" crlf)
)
(defrule Kaukaz
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to gory Kaukaz w Rosji" crlf)
)
(defrule GorySkaliste
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Gory Skaliste w Kanadzie" crlf)
)
(defrule Alaska
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to gory Alaska na Alasce" crlf)
)
;;;;;;;;;;;;;;;;;;;
(defrule Moskwa
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to miasto Moskwa w Rosji" crlf)
)
(defrule Rejkiawik
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to miasto Rejkiawik na Islandii" crlf)
)
(defrule Tokyo
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to miasto Tokyo w Japonii" crlf)
)
(defrule NowyJork
	(cieplo nie)
	(polska nie)
	(aktywnie tak)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to miasto Nowy Jork w USA" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule Bieszczady
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce gory)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to gory Bieszczady w Polsce" crlf)
)
(defrule GoryStolowe
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce gory)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Gory Stolowe w Polsce" crlf)
)
(defrule Pieniny
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce gory)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to gory Pieniny w Polsce" crlf)
)
(defrule Tatry3
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce gory)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to gory Tatry w Polsce" crlf)
)
;;;;;;;;;;;;;;;;;
(defrule Ustka
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce plaza)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Ustka w Polsce" crlf)
)
(defrule Miedzywodzie
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce plaza)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Miedzywodzie w Polsce" crlf)
)
(defrule Hel
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce plaza)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Hel w Polsce" crlf)
)
(defrule KrynicaMorska
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce plaza)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Krynica Morska w Polsce" crlf)
)
;;;;;;;;;;;;;;;;;;;;;
(defrule Wroclaw2
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce miasto)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to miasto Wroclaw w Polsce" crlf)
)
(defrule Gdynia
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce miasto)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to miasto Gdynia w Polsce" crlf)
)
(defrule Warszawa2
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce miasto)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to miasto Warszawa w Polsce" crlf)
)
(defrule Krakow2
	(cieplo nie)
	(polska tak)
	(aktywnie nie)
	(miejsce miasto)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to miasto Krakow w Polsce" crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule Ramberg
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Ramberg w Norwegii" crlf)
)
(defrule Hietaniemi
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Hietaniemi w Finlandii" crlf)
)
(defrule RauhaniemiBeach
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Rauhaniemi Beach w Finlandii" crlf)
)
(defrule Gotlandia
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Gotlandia w Szwecji" crlf)
)
;;;;;;;;;;;;;;;;;
(defrule Tatry4
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Tatry na Slowacji" crlf)
)
(defrule Lom2
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Lom w Norwegii" crlf)
)
(defrule Are2
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Are w Szwecji" crlf)
)
(defrule Alpy3
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce gory)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Alpy w Austrii" crlf)
)
;;;;;;;;;;;;;;;;
(defrule Bratysława
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce miesto)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Bratysława na Slowacji" crlf)
)
(defrule Budapeszt
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce miesto)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Budapeszt na Wegrzech" crlf)
)
(defrule Amsterdam 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce miesto)
	(eu tak)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Amsterdam w Holandii" crlf)
)
(defrule Marsylia 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce miesto)
	(eu tak)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Marsylia we Wloszech" crlf)
)
;;;;;;;;;;;;;;;;;
(defrule Hellnar 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Hellnar na Islandii" crlf)
)
(defrule Hofn
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Hofn na Islandii" crlf)
)
(defrule ShirarahamaBeach
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Shirarahama Beach w Japonii" crlf)
)
(defrule Grenlandia 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce plaza)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to Grenlandia" crlf)
)
;;;;;;;;;;;;;;;;;;
(defrule Taurus4 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to Taurus w Turcji" crlf)
)
(defrule Kaukaz2 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to Kaukaz w Rosji" crlf)
)
(defrule GorySkaliste2 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to Gory Skaliste w Kanadzie" crlf)
)
(defrule Alaska2 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce gory)
	(eu nie)
	(przedzial_cen 4)
	=>	
	(printout t "Twoje miejsce to gory Alaska na Alasce" crlf)
)
;;;;;;;;;;;;;;;;
(defrule Petersburg 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to miasto Petersbugr w Rosji" crlf)
)
(defrule Pekin 
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to miasto Pekin w Chiny" crlf)
)
(defrule Toronto
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 3)
	=>	
	(printout t "Twoje miejsce to miasto Toronto w Kanadzie" crlf)
)
(defrule SanFrancisco
	(cieplo nie)
	(polska nie)
	(aktywnie nie)
	(miejsce miasto)
	(eu nie)
	(przedzial_cen 4)
	=>
	(printout t "Twoje miejsce to miasto San Francisco w USA" crlf)
)
;;;;;;;;;;;;;;;













