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


(defrule start
  	(declare (salience 500))
  	=>
  	(printout t "Wybierz miejsce swoich wakacji zimowych! " crlf)
	(printout t "Wystarczy, ze bedziesz odpowiadac na pytania odpowiedziami z nawiasow na koncu kazdego pytania." crlf)
  	(printout t "Zaczynajmy." crlf)
	(printout t "" crlf)
  	(assert (print-list list))
  	)





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


(defrule polska2
	(cieplo tak)
	=>
	(assert (polska brak))
)


(defrule aktywnie
	(tak ?tak)
	(nie ?nie)
  	=>
	(printout t "Czy na miejscu maja byc opcje spedzania wakacji aktywnie? (przeciwienstwem jest miejsce z brakiem aktywnych atrakcji lub miejsce z nieobowiazkowymi aktywnosciami)" crlf)
	(printout t "Aktywne atrakcje rozumiemy jako uprawianie sportow, mozliwosci dlugich wycieczek i zwiedzania, sportowe atrakcje hotelowe" crlf)
  	(printout t "Czy ma byc aktywnie : (tak/nie)?" crlf)
  	(assert (aktywnie =(read)))
  	)
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


(defrule miejsce
	(miasto ?miasto)
	(plaza ?plaza)
	(gory ?gory)
  	=>
	(printout t "Wybierz miejsce miejsce dominujace podczas wybranych wakacji zimowych." crlf)
	(printout t "Glownymi miejscami sa plaza, gory lub miasto. Wybranie jednego z nich nie wyklucza obecnosci pozostalych, gwarantuje ze bedzie to miejsce dominujace na wyjezdzie." crlf)
	(printout t "(przy wyborze opcji 'gory' oraz opcji 'cieple' w wczesniejszym pytaniu musimy liczyc sie z tym ze gory beda w cieplym obszarze, ale w gorach juz raczej nie bedzie cieplo ze wzgledu na roznice wysokosci)" crlf)
  	(printout t "Wybierz miejsce przewodnie : (plaza/gory/miasto)?" crlf)
  	(assert (miejsce =(read)))
  	)
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


(defrule eu
	(or(polska nie)(polska brak))
	(tak ?tak)
	(nie ?nie)
  	=>
	(printout t "Czy miejsce wakacji ma znajdowac sie w Europie? (przeciwienstwem jest miejsce wakacji poza Europa)" crlf)
  	(printout t "Czy miejscem wakacji ma byc europa? : (tak/nie)?" crlf)
  	(assert (eu =(read)))
  	)
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




(defrule CostaDelSol
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 1)
	=>	
	(printout t "Twoje miejsce to wybrzeze Costa del Sol w Hiszpani" crlf)
)
(defrule GranCanaria
	(cieplo tak)
	(polska brak)
	(aktywnie tak)
	(miejsce plaza)
	(eu tak)
	(przedzial_cen 2)
	=>	
	(printout t "Twoje miejsce to wyspa Gran Canaria w Hiszpani" crlf)
)




