% Damiano Bressanin 138075
% esercizio delle Divisioni delle sfere d'oro.

:- lib(fd).

calcola_cubi(N, N, [H]):- !, H is N*N*N.
calcola_cubi(Acc, N, [H|T]):- Acc<N,
                              H is Acc*Acc*Acc,
                              NextAcc is Acc+1,
                              calcola_cubi(NextAcc, N, T).


somma_lista([], 0).
somma_lista([H|T], K):- K#=H+K1, somma_lista(T,K1).

somma_pesata([], [], 0).
somma_pesata([H|T], [Boolean|TB], Somma):- Somma #= H*Boolean+Somma1, somma_pesata(T, TB, Somma1).

csp(N, Fratelli) :-
                 length(Fratelli, N),
                 Fratelli::0..1,
                 calcola_cubi(1, N, Pesi_Sfere),
                 
                 somma_lista(Pesi_Sfere, SommaSfere),
                 
                 Meta_SommaSfere * 2 #= SommaSfere,
                 
                 somma_pesata(Pesi_Sfere, Fratelli, Somma_Fratello),
                 Somma_Fratello #= Meta_SommaSfere,
                 

                 labeling(Fratelli).
                 
% le sfere con indice 0 se le prende il primo fratello, le sfere con indice 1 se le prende il secondo fratello.

