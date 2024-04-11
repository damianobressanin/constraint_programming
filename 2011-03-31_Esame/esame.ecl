% Damiano Bressanin 138075
% esame 31/03/2011

% importo le librerie
:- lib(fd).
:- lib(edge_finder3).

% leggo il file
:- [task].


clp(Tmax, Lstart):-
        % prendo le durate dei task e li metto nella lista Ldur
        findall(D, task(_,D), Ldur),
        % ho un task per ogni durata, quindi il numero di task è pari alla lunghezza della lista Ldur
        length(Ldur, Ntask),
        % ogni task ha un istante di inizio che viene salvato nella lista Lstart
        length(Lstart, Ntask),
        % impongo il vincolo di terminare ogni task entro Tmax
        max_span(Lstart, Ldur, Tmax),
        % creo una variabile aggiuntiva
        FreeRes::0..Ntask,
        % creo una lista di 1 lunga come il numero dei task
        lista_uno(Ones, Ntask),
        % uso il vincolo cumulative
        edge_finder3:cumulative([0|Lstart], [Tmax|Ldur], [FreeRes|Ones], Ntask),
        % risorse usate
        UsedRes #= Ntask-FreeRes,
        % faccio l'append per averle nella stessa lista
        append(Lstart, [UsedRes], Lvars),
        % minimizzo il numero di risorse usate dagli altri task
        minimize(labeling(Lvars), UsedRes).
        


% devo imporre che tutti i task finiscano entro Tmax
% max_span(Lstart, Ldur, Tmax).

max_span([],[],_).
max_span([Start|TailStart], [Dur|TailDur], Tmax):-
        Start + Dur #<= Tmax,
        max_span(TailStart,TailDur,Tmax).

% creo una lista lunga N di 1
lista_uno([], 0).
lista_uno([1|T], N) :-
        N1 is N-1,
        lista_uno(T,N1).

