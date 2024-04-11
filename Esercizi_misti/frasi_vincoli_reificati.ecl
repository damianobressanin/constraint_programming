% DAMIANO BRESSANIN 138075

/*
Ad ogni vincolo reificato viene associata una variabile B che indica se il vincolo è stato soddisfatto (B=1) oppure no (B=0).
Quindi B è una nuova variabile, con valori booleani, che posso utilizzare per i miei scopi.
esempio: C #> D #<=> B
         se la disuguaglianza è vera allora B=1
         se la disuguaglianza è falsa allora B=0



VARIABILI, DOMINI e VINCOLI:

- VARIABILI del problema:
Cerco i valori di verità delle varie frasi (statements) assegnate nel testo.
Quindi mi interessa sapere il valore della loro variabile B associata.
Quindi le mie variabili sono B1, B2, ..., B20 perché ho esattamente 20 frasi da controllare.

- DOMINI delle variabili:
Le variabili B1, B2, ..., B20 sono di tipo booleano, quindi possono assumere solo valore 0 e 1.

- VINCOLI tra le variabili:
Quelli dettati dalle frasi, li trascrivo direttamente nel codice.
*/

:- lib(fd).

frasi(B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16, B17, B18, B19, B20) :-

        % metto i domini alle variabili
        [B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16, B17, B18, B19, B20] :: [0,1],
        
        % La frase 1 è vera se e solo se la risposta della frase 6 e della frase 7 sono uguali.
        % Quindi B1 memorizza il valore di verità della frase 1, e così via per le altre B.
        
        % i)
        B6 #= B7 #<=> B1, 
        
        % ii)
        B1 #= 0 #<=> B2,
        
        % iii)
        B4 #\= B20 #<=> B3,
        
        % iv)
        B3 #\= B20 #<=> B4,
        
        % v)
        B5 #\= B19 #<=> B5,
        
        % vi)
        B2 #= 1 #<=> B6,
        
        % vii)
        B15 #= 1 #<=> B7,
        
        % viii)
        B11 #= B19 #<=> B8,
        
        % ix)
        B10 #= 1 #<=> B9,
        
        % x)
        B13 #= 0 #<=> B10,
        
        % xi)
        % non c'entra niente: non ho elementi per legare questa frase con le altre, quindi questa frase non crea vincoli con B11
        
        % xii)
        B16 #= 1 #<=> B12,
        
        % xiii)
        B12 #= 1 #<=> B13,
        
        % xiv)
        B14 #= B11 #<=> B14,
        
        % xv)
        % dato che abbiamo mappato i valori di verità con 0 e 1, risulta facile capire quante frasi sono vere e quante sono false.
        % basta sommare i valori delle variabili B e imporre che siano <= 10 (metà del numero di frasi).
        (B1+B2+B3+B4+B5+B6+B7+B8+B9+B10+B11+B12+B13+B14+B15+B16+B17+B18+B19+B20) #<= 10 #<=> B15,
        
        % xvi)
        % identico al precedente ma si usa il vincolo >= 10
        (B1+B2+B3+B4+B5+B6+B7+B8+B9+B10+B11+B12+B13+B14+B15+B16+B17+B18+B19+B20) #>= 10 #<=> B16,
        
        % xvii)
        B9 #= B4 #<=> B17,
        
        % xviii)
        B7 #= 1 #<=> B18,
        
        % ixx)
        % non c'entra niente: non ho elementi per legare questa frase con le altre, quindi questa frase non crea vincoli con B19
        
        % xx)
        B3 #\= B4 #<=> B20,
        
        % ho finito le frasi e faccio il labeling.
        labeling([B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16, B17, B18, B19, B20]).