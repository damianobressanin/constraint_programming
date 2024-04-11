% Damiano Bressanin 138075

% installo tutti i pacchetti
{install(P)} :- package(P).

% non posso installare un pacchetto e non le sue dipendenze
:- install(P1), requires(P1,P2), not install(P2).

% non posso installare due pacchetti in conflitto
:- conflict(P1,P2), install(P1), install(P2).

% si fa un cambiamento quando si installa un pacchetto che non era già installato
change(P):- package(P), install(P), not installed(P).

% si fa un cambiamento quando si rimuove un pacchetto che era già installato
change(P):- package(P), not install(P), installed(P).

% minimizzo il numero di cambiamenti
#minimize { 1,P:change(P)}.

#show install/1.
#show change/1.