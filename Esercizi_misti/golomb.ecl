% DAMIANO BRESSANIN 138075

/*
TESTO:
Si scriva un predicato CLP "golomb(L, N, Lmax)" che calcola un righello di Golomb con N tacche di lunghezza massima Lmax.


VINCOLI:
1) Le distanze fra due tacche qualsiasi devono essere tutte diverse.
2) Non posso avere due tacche nello stesso punto del righello.
*/


% importo le librerie solite
:- lib(fd).
:- lib(fd_global).
:- import alldifferent/1 from fd_global.

% importo la libreria per il flatten delle liste trovata nella documentazione perché non voglio riscriverla a mano.
:- lib(lists).
:- import flatten/2 from lists.

% funzione ausiliaria usata in "differenze/2". Mi serve per costruire una lista di distanze delle tacche.
aiutadifferenze(_, [], []).
aiutadifferenze(H1, [H2|T2], [A|L]) :- A #= abs(H2-H1), aiutadifferenze(H1, T2, L).

% creo una lista di liste di distanze fra tutte le tacche.
differenze([], []). 
differenze([H|T], [Ris|L]) :- aiutadifferenze(H, T, Ris), differenze(T, L).

% ordino le tacche in senso crescente
ordina([_]):-!.
ordina([H1,H2|T]):- H1#<H2, ordina([H2|T]).



% predicato da invocare per calcolare i righelli di Golomb
golomb(L, N, Lmax) :-
                     % usando la reversibilità della funzione "length" creo le N variabili che rappresentano le tacche del righello
                     length(L, N),
                     
                     % ogni tacca può assumere un valore intero tra 0 e Lmax
                     L::0..Lmax,
                     
                     % non posso avere 2 tacche nello stesso posto
                     alldifferent(L),
                     
                     % le tacche di un righello sono ordinate in senso crescente (ed evito le permutazioni delle tacche)
                     ordina(L),
                     
                     % calcolo le distanze fra tutte le tacche
                     differenze(L, Nestedlist),
                     
                     % trasformo la lista di liste in una lista "piatta"
                     flatten(Nestedlist, Flatlist),
                     
                     % le distanze tra 2 tacche qualsiasi devono essere diverse
                     alldifferent(Flatlist),

                     % faccio il labeling
                     labeling(L).

