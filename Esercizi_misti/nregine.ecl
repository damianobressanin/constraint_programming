%ES N regine
:- lib(fd).

regine(L,N) :-
    %lista di N variabili intere con dominio da 1 a N
    length(L,N),
    L :: 1..N,

    %calcola le diagonali
    %N1 #= N - 1,
    incremento(L,0,LDiag1),
    decremento(L,N,LDiag2),


    %tutte le righe e colonne sono diverse
    alldifferent(L),

    %diagonali
    alldifferent(LDiag1),
    alldifferent(LDiag2),

    labeling(L).

incremento([],_,[]).
incremento([H|T],Start,[Hout|Tout]) :-   Hout #= H + Start, Start1 #= Start + 1, incremento(T,Start1,Tout).

decremento([],_,[]).
decremento([H|T],Stop,[Hout|Tout]) :-   Hout #= H + Stop, Stop1 #= Stop - 1, decremento(T,Stop1,Tout).
