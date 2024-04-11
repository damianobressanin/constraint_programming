% il nodo 1 è raggiungibile
reachable(1).

% un nodo X è raggiungibile se esiste un altro nodo Y raggiungibile e esiste un arco che collega Y a X
reachable(X):-
        reachable(Y),
        edge(Y,X).

% direttiva show per mostrare solo il predicato reachable nel terminale
#show reachable/1.




