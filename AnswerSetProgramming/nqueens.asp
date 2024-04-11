% Damiano Bressanin 138075
% N-regine


% Suggerimento:
% Utilizzare un predicato "queen(R,C) che è vero se è stata posizionata una regina nella riga R colonna C"


% creo la scacchiera
scacchiera(1).
scacchiera(N+1):- scacchiera(N), N<8.


% faccio tutte le combinazioni
{queen(R,C)} :- scacchiera(R), scacchiera(C).


% Non va bene quando:
% ho due regine nella stessa riga
:- queen(R1,C1), queen(R2, C2), R1=R2.
% ho due regine nella stessa colonna
:- queen(R1,C1), queen(R2, C2), C1=C2.
% ho due regine nella stessa diagonale
:- queen(R1,C1), queen(R2,C2), R1+C1=R2+C2.
:- queen(R1,C1), queen(R2,C2), R1-C1=R2-C2.



#show queen/2.
