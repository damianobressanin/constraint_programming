% Damiano Bressanin 138075
% graph coloring in ASP usando gli aggregati


% se N è un nodo
% allora deve avere esattamente 1 colore (minimo 1 e massimo 1 colore)
1{color(N,rosso); color(N,blu); color(N,verde)}1 :- nodo(N).

% do fallimento se due nodi sono vicini e hanno lo stesso colore
:- edge(Nodo1,Nodo2), color(Nodo1, C), color(Nodo2, C).

#show color/2.