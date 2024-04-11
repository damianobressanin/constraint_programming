% Damiano Bressanin 138075
% esercizio cena insiemi
:-lib(fd).
:-lib(fd_sets).
cena(N,L):-
        % esplicito il numero dei giorni
        Giorni1 #= N-1,
        Giorni2 #= Giorni1*N,
        Giorni*6#= Giorni2,
        % ogni giorno è un insieme
        % L è la lista di insiemi, è lunga come Giorni e ci posso inserire gli N amici
        intsets(L, Giorni, 1, N),
        % ho una lista di insiemi, quindi devo applicare il vincolo a tutti gli insiemi uno alla volta
        applica_cardinalita(L),
        % faccio l'intersezione tra tutti gli insiemi e fisso la cardinalità di ogni intersezione pari a 1
        %applica_intersezione(L),
        scorri_lista(L),
        % devo fare il labeling a tutti gli (Giorno) insiemi contenuti in L
        applica_labeling(L).


applica_labeling([]).
applica_labeling([H|T]):-
        % labeling per 1 insieme (parametri di default)
        insetdomain(H,_,_,_),
        % chiamata ricorsiva
        applica_labeling(T).

scorri_lista([]).
scorri_lista([H|T]):-
        applica_int(H,T),
        scorri_lista(T).
         
applica_int(_, []).
applica_int(X, [H|T]):-
        % creo l'intersezione tra gli insiemi
        fd_sets:(intersection(X,H,Int)),
        % impongo che la sua cardinalità sia 0 o 1
        fd:(Card::0..1),
        #(Int,Card),
        % chiamata ricorsiva
        applica_int(X, T).

% inizialmente avevo usato questa ma va ad applicare solo alle coppie adiacenti
applica_intersezione([_]).
applica_intersezione([A,B|T]):-
        % creo l'intersezione tra gli insiemi
        fd_sets:intersection(A,B,Int),
        % impongo che la sua cardinalità sia 0 o 1
        fd:(Card::0..1),
        #(Int,Card),
        % chiamata ricorsiva
        applica_intersezione([B|T]).

applica_cardinalita([]).
applica_cardinalita([H|T]):-
        % ad ogni cena sono presenti esattamente 3 amici
        #(H,3),
        % chiamata ricorsiva
        applica_cardinalita(T).       