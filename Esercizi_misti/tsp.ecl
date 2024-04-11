% DAMIANO BRESSANIN 138075 ESERCIZIO TSP
ncitta(10).
dista(1, 2, 88).
dista(1, 3, 66).
dista(1, 4, 60).
dista(1, 5, 26).
dista(1, 6, 49).
dista(1, 7, 92).
dista(1, 8, 18).
dista(1, 9, 89).
dista(1, 10, 74).
dista(2, 1, 88).
dista(2, 3, 71).
dista(2, 4, 76).
dista(2, 5, 55).
dista(2, 6, 99).
dista(2, 7, 39).
dista(2, 8, 50).
dista(2, 9, 82).
dista(2, 10, 73).
dista(3, 1, 66).
dista(3, 2, 71).
dista(3, 4, 57).
dista(3, 5, 8).
dista(3, 6, 58).
dista(3, 7, 17).
dista(3, 8, 75).
dista(3, 9, 51).
dista(3, 10, 34).
dista(4, 1, 60).
dista(4, 2, 76).
dista(4, 3, 57).
dista(4, 5, 44).
dista(4, 6, 78).
dista(4, 7, 87).
dista(4, 8, 64).
dista(4, 9, 32).
dista(4, 10, 44).
dista(5, 1, 26).
dista(5, 2, 55).
dista(5, 3, 8).
dista(5, 4, 44).
dista(5, 6, 73).
dista(5, 7, 9).
dista(5, 8, 95).
dista(5, 9, 24).
dista(5, 10, 95).
dista(6, 1, 49).
dista(6, 2, 99).
dista(6, 3, 58).
dista(6, 4, 78).
dista(6, 5, 73).
dista(6, 7, 91).
dista(6, 8, 46).
dista(6, 9, 56).
dista(6, 10, 72).
dista(7, 1, 92).
dista(7, 2, 39).
dista(7, 3, 17).
dista(7, 4, 87).
dista(7, 5, 9).
dista(7, 6, 91).
dista(7, 8, 92).
dista(7, 9, 47).
dista(7, 10, 92).
dista(8, 1, 18).
dista(8, 2, 50).
dista(8, 3, 75).
dista(8, 4, 64).
dista(8, 5, 95).
dista(8, 6, 46).
dista(8, 7, 92).
dista(8, 9, 84).
dista(8, 10, 62).
dista(9, 1, 89).
dista(9, 2, 82).
dista(9, 3, 51).
dista(9, 4, 32).
dista(9, 5, 24).
dista(9, 6, 56).
dista(9, 7, 47).
dista(9, 8, 84).
dista(9, 10, 94).
dista(10, 1, 74).
dista(10, 2, 73).
dista(10, 3, 34).
dista(10, 4, 44).
dista(10, 5, 95).
dista(10, 6, 72).
dista(10, 7, 92).
dista(10, 8, 62).
dista(10, 9, 94).


:-lib(fd).
:-lib(propia).
:- lib(fd_global).
:- import alldifferent/1 from fd_global.
:- lib(listut).
tsp(L):-
        % leggo il numero di città e lo salvo in una variabile Ncitta
        ncitta(Ncitta),
        % creo la lista di variabili
        length(L,Ncitta),
        % metto il dominio
        L::0..10,
        % non posso ritornare sulla stessa città
        alldifferent(L),
        % salvo la prima città perché dopo ci voglio ritornare
        nth1(1, L, Prima),
        vincolo_distanza(L, Prima, Km),
        minimize(labeling(L),Km).

% predicato per calcolare la distanza totale e per imporre che le città vicine siano collegate
% vincolo_distanza(L, Prima, Costo)

% caso base: ho solo una città nella lista e devo ritornare alla città di partenza
vincolo_distanza([Ultimacitta], Prima, Km_ritorno):-
        dista(Ultimacitta, Prima, Km_ritorno) infers most.

% caso ricorsivo:
% la distanza tra la città corrente e la prossima deve essere uguale a Km_c1c2
% chiamata ricorsiva utilizzando Km_cnext
% la distanza finale deve essere uguale alla distanza tra la città e quella successiva + gli altri km
vincolo_distanza([C1, C2|T], Prima, Km_out):-
        % ho notato che se si sposta qui sopra il vincolo a #= si risparmiano 200ms
        infers(dista(C1, C2, Km_c1c2),most),
        vincolo_distanza([C2|T], Prima, Km_cnext),
        Km_out #= Km_c1c2 + Km_cnext.
        