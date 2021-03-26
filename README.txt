Gradinaru Cristian - 332AC

Tema contine in total 4 module, fiecare implementat in concordanta cu cerintele precizate, dupa cum urmeaza:
	TempTop-	modulul de top, cel in care sunt instantiate si conectate toate celelalte module. 
		 	El contine variabilele necesare calcularii sumei temperaturilor intr-un vector de 5 senzori concatenati, si are drept rol
		 	buna functionare a ansamblului. Fara acest modul de top nu am putea solutiona sarcinile atribuite.
		 	Ca si continut, el contine instantierea fiecarui dintre celorlalte 3 module, precum si o transformare a variabilei active sensors
		 	de pe 8 pe 16 biti, pentru a putea fi folosita de catre modulul division( care accepta parametri de 16 biti);
	Sensors_input-  modulul unde se calculeaza suma elementelor continute in sensors data. acest lucru se face cu ajutorul unei tehnici de selectie
			a bitilor pe care am gasit-o in documentatia din textul temei: aceasta are forma de [8*i =: 8] adica de la un i=0 pana la i=5 
			valoarea va lua 8 biti consecutivi incepand cu valoarea 8*i, iar acest lucru se va realiza numai daca senzorul respectiv este activ.
			In acelasi timp cu aceasta suma se incrementeza si valoarea senzorilor activi pentru a putea furniza aceste date modului de diviziune
			care va urma sa faca impartirea intre aceste doua valori pentru a obtine o temperatura medie raportata de senzorii activi.
	Division- 	modulul care realizeaza impartirea propriu zisa intre cele doua numere furnizate de Sensors_input: dat fiind ca operatiile de
			/ si % nu sunt sintetizabile trebuie sa gasim o modalitate de a realiza acest proces intr-o maniera sintetizabila. Am abordat algoritmul
			de tip long division din documentatie, care efectueaza operatia de impartire folosind doar operatii sintetizabile precum scaderea sau shiftarea de biti
			si fara a implementa instructiuni de tipul for sau while cu numar variabil de iteratii.
			Acest modul furnizeaza mai departe catul si restul impartirii celor doua numere, date care urmeaza sa fie folosite de catre urmatorul modul: output_display
	output_display- Acest modul este cel mai complex dintre cele de pana acum deoarece el realizeaza aproximarea temperaturii si totodata stabileste codul de iesire
			si valoarea semnalului de alerta necesare pentru functionalitatea acestui ansamblu de module.
			In prima faza, cele doua variabile sunt initializate cu 0, ca sa pornim mereu din acelasi loc. In continuare urmeaza secventa care aproximeaza temperatura:
			Daca restul este cel putin jumatate din impartitor, atunci numarul inregistrat este de forma X.5 si deci trebuie aproximat prin adaos catre prima valoare intreaga
			mai mare decat aceasta, in caz contrar valoarea poate ramane cat era intiial. Odata ce avem aceasta temperatura, putem sa incepem secventa de comparare si incadrare a temperaturii in harta de valori din enuntul temei.
			Am distins 3 cazuri posibile: daca valoarea este mai mica de 19 grade, atunci valoarea codata este una singura iar semnalul de alerta ia valoarea 1, iar foarte similar
			este si cazul cand temperatura este mai mare de 26, moment in care semnalul de alerta ia din nou valoarea 1, iar iesirea codata are valoarea din extrema opusa cazului mentionat anterior.
			Cazul mai complex este acela cand temperatura se afla in intervalul specificat, deoarece acum trebuie sa stabilim carei valori de pe harta de temperatura ii corespunde si 
			sa stabilim o regula pentru a putea transmite codul de iesire intr-o maniera cat se poate de eficienta. Dat fiind ca codul de alarma este mereu 0 in acest caz, acesta nu prezinta o dificultate
			mare in implementare, iar in ceea ce priveste semnalul codat de iesire, am observat ca odata cu fiecare crestere de 1 grad de la valoarea 19, semnalul codat de iesire primeste un 1 pe pozitia i
			si deci astfel, pentru fiecare incrementare a valorii i , semnalul se apropie cu 1 bit de cel pentru temperatura 26, iar atunci cand temperatura este aceeasi cu cea stocatata semnalul codat
			de iesire este inregistrat si transmis mai departe.
			Astfel putem stabili semnalele de iesire pentru orice variatie a variabilelor de intrare.