% Damiano Bressanin 138075
% graph coloring in ASP

palette(rosso).
palette(verde).
palette(blu).

% per ogni nodo e per ogni colore assegna tutte le combinazioni
{color(N,C)}:- palette(C), nodo(N).

% do fallimento se un nodo non è stato colorato
:- nodo(N), not colorato(N).

% ma cosa significa "colorato"?
% significa che un nodo N è colorato se esiste un colore C che colora il nodo N
colorato(N):- color(N,C).

% do fallimento se due nodi vicini hanno lo stesso colore
:- near(Nodo1, Nodo2), color(Nodo1, Colore), color(Nodo2,Colore).

% do fallimento se un nodo è stato colorato con due colori diversi contemporaneamente
:- color(N,C1), color(N,C2), C1 != C2.

#show color/2.