% Damiano Bressanin 138075 esercizio 12/07/2007

% VARIABILI: celle matrice

% DOMINI: 0 e 1

% VINCOLI:
% le righe devono essere ordinate in ordine lessicografico
% si vuole massimizzare la minima distanza di Hamming fra le righe consecutive

% la distanza di Hamming fra due sequenze di bit è il numero di bit diversi nella stessa posizione

% importo le librerie
:- lib(fd).
:- lib(fd_global).
:- lib(matrix_util).

% in input do due numeri per le righe e le colonne e mi restituisce la Matrice binaria
codice(N, M, Matr):-
        % creo la matrice
        matrix(N,M, Matr),
        
        % la appiattisco per avere una lista di variabili con dominio 0 e 1
        % mi servirà per fare il labeling sulle variabili singole, cioé le celle della matrice
        flatten(Matr, Flat),
        Flat::0..1,
        
        % creo la lista di distanze e prendo il valore minimo
        distanze(Matr, LDistanze),
        minlist(LDistanze, DistMin),
        
        % problema di massimo, quindi devo cambiare di segno
        Dnegato #= -DistMin,
        min_max(labeling(Flat), Dnegato).


% crea una lista di distanze fra le righe consecutive
% prende in ingresso una lista di liste (matrice) e restituisce una lista di distanze (di Hamming)
% A e B sono liste
distanze([_],[]).
distanze([A,B|T], [D|LD]):-
        % io devo lavorare sulle liste singole, quindi uso una funzione ausiliaria dist
        % che prende in ingresso due liste e restituisce la loro distanza di Hamming
        dist(A,B,D),
        % vincolo: le due righe devono essere ordinate
        lexico_le(A,B),
        % chiamata ricorsiva
        distanze([B|T], LD).

% prende in ingresso due liste e restituisce un intero
% cioé prende due righe della matrice e restituisce la loro distanza di Hamming
dist([], [], 0).
dist([HA|LA], [HB|LB], D) :- 
        % lavoro con due righe ma con la stesso indice di colonna
        % se le due colonne hanno valori diversi allora Diversi vale 1, altrimenti vale 0
        HA #\= HB #<=> Diversi,
        % e lo aggiungo al contatore
        D #= Diversi+D1,
        % chiamata ricorsiva
        dist(LA, LB, D1).