% Ripasso Prolog


mymember(E,[E|T]).
mymember(E, [H|T]):-mymember(E, T).


% L è l'ultimo elemento della lista X
mylast(L,[L]).
mylast(L, [H|T]):-mylast(L,T).




% mylength(L,N) "la lista L ha N elementi"
mylength([],0).
mylength([H|T], N):-mylength(T,N1), N is N1+1.


% fatt(N,Y) "prendi il fattoriale di N e mettilo in Y"
fatt(0,1).
fatt(N,Y):- N1 is N-1, fatt(N1, Y1), Y is Y1*N.


% fibonacci(N,Y) "prendi il numero di fibonacci di N e mettilo in Y"
fib(0,0).
fib(1,1).
fib(N,Y):- N > 1,
           N1 is N-1, fib(N1,Y1),
           N2 is N-2, fib(N2,Y2),
           Y is Y1+Y2.
           


% conta(T,L,N) "N è il numero di occorrenze del termine T nella lista L"
conta(T, [], 0).
conta(T, [T|Tail], N) :- conta(T,Tail, N1), N is N1+1.
conta(T, [Head|Tail], N) :- conta(T, Tail, N).

% sum_list(L,S) "S è la somma degli elementi della lista L"
my_sum_list([], 0).
my_sum_list([H|T], S) :- my_sum_list(T,S1), S is S1+H.


% myappend(Ris, L1, L2) "Ris è la lista L1 con in coda la lista L2"
myappend(L2, [], L2).
myappend([H1|T], [H1|T1], L2):- myappend(T,T1,L2).


% rifai la member usando il predicato cut ! (si perde l'invertibilitù del codice con !)
cut_member(E, [E|T]):-!.
cut_member(E, [H|T]):- cut_member(E, T).







