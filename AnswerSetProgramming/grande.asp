% Damiano Bressanin 138075

% esercizio "grande"
% scrivere un predicato "grande" che è vero solo se il massimo dei valori che rendono vero p è maggiore di 2

p(1).
p(3).
p(5).

grande :- 2 < #max{X:p(X)}.


#show grande/0.


% esercizio "somma"
% scrivere un predicato "somma(S)" in cui S è la somma dei valori che rendono vero il predicato p.

% lo faccio generalizzato con i primi numeri naturali.
numeri(1).
numeri(N+1) :- numeri(N), N<20.

% sceli tutte le possibili combinazioni di numeri
{scelto(N)} :- numeri(N).

% tranne quelli sbagliati
:- sbagliato.

% ma quando è che è sbagliato? quando la somma dei numeri scelti è > 10
sbagliato :- #sum{X:scelto(X)}>10.


#show scelto/1.

