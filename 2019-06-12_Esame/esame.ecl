% Damiano Bressanin 138075
% esame 12/06/2019

:- lib(fd).
:- lib(fd_global).
:- lib(listut).

:- [production].


esame(L):-
        findall(ordine(ID, Deadline), ordine(ID, Deadline), Lordini),
        findall(precedenza(A, B),precedenza(A, B), Lprecedenze),
        endtime(Endtime),
        
        length(Lordini, Nordini),
        length(L, Nordini),
        
        fd_global:alldifferent(L),
        
        L::1..Nordini,
        
        max_end(L, Endtime),
        
        vincolo_precedenza(Lprecedenze, L),
        
        guadagno(Lordini, L, Guadagno),
        
        GuadagnoNegativo #= - Guadagno,
        minimize(labeling(L), GuadagnoNegativo).
        

% guadagno(Lordini, L, Guadagno)
guadagno([], _, 0).
guadagno([ordine(ID, Deadline)|T], L, Guadagno) :-
        nth1(ID, L, Ordine),
        Ordine #< Deadline #<=> B,
        guadagno(T, L, Guadagno1),
        Guadagno #= Guadagno1 + B.


% max_end(L, Endtime)
max_end([], _).
max_end([H|T], Endtime) :-
        H #=< Endtime,
        max_end(T, Endtime).
        

% vincolo_precedenza(Lprecedenze, L)
vincolo_precedenza([precedenza(A, B)|T], L) :- 
        nth1(A, L, EndA),
        nth1(B, L, EndB),
        EndA #< EndB,
        vincolo_precedenza(T,L).


