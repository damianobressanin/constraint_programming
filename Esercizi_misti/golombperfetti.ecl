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

% mi sono accorto che non mi serve ma ormai l'ho scritta.
% rimuovi_doppioni(Lista, Ris)
rimuovi_doppioni([Ultimo], [Ultimo]).
rimuovi_doppioni([H|T], [H|L]):- \+ member(H,T),!, rimuovi_doppioni(T, L).
rimuovi_doppioni([H|T], L):- member(H,T), rimuovi_doppioni(T,L).



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
                     
                     % voglio solo i righelli di Golomb perfetti (si dice "perfetto" un righello di Golomb che riesce a misurare tutte le lunghezze fino a Lmax).
                     % se è perfetto allora il numero di distanze misurabili deve essere uguale a Lmax
                     K::0..Lmax,
                     length(Flatlist,K),
                     K #= Lmax,
                     
                     % faccio il labeling
                     labeling(L).


% Dati presi da Wikipedia https://it.wikipedia.org/wiki/Regolo_di_Golomb

% esempio di righelli di Golomb perfetti
% ordine    lunghezza          tacche
% 1	       0               	0
% 2	       1                0 1	
% 3	       3                0 1 3	
% 4	       6                0 1 4 6
% Sono perfetti perché riesco a misurare tutte le distanze tra 0 e la lunghezza del righello.

% esempio di tighello di Golomb non perfetto:
% ordine    lunghezza          tacche
%   5           11              0 1 4 9 11
% non è perfetto perché non riesco a misurare la lunghezza 6






