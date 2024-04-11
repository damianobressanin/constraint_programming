% Damiano Bressanin 138075

:- lib(fd).
:- lib(fd_global).
:- lib(edge_finder3).
:- [task].

esame(Lstart) :-
        % leggo i dati di input
        findall(task(ID, EST, LCT, D), task(ID, EST, LCT, D), Ltask),
        % lista durate
        findall(D, task(ID, EST, LCT, D), Ldurate),
        % trovo il numero di task e fisso la lunghezza di Lstart
        length(Ltask, Ntask),
        length(Lstart, Ntask),
        Lstart::0..1000000,
        % le stampe non si devono sovrapporre
        edge_finder3:disjunctive(Lstart, Ldurate),
        % impongo i vincoli su EST e LCT
        est_lct(Lstart, Ltask),
        % creo la lista di differenze
        scorrilista(Lstart, Ldurate, LLdifferenze),
        % appiattisco la lista di liste
        flatten(LLdifferenze, Ldifferenze),
        % prendo la differenza con il valore più basso
        minlist(Ldifferenze, DifferenzaMinima),
        % inverto il segno: problema di massimo
        Negata #= -DifferenzaMinima,
        minimize(labeling(Lstart), Negata).
        
        
% creo la lista di liste di differenze
% scorrilista(Lstart, Ldurate, LLdifferenze).
scorrilista([],[],[]).
scorrilista([S|TS], [D|TD], [Ris|T]) :-
        differenze(S, D, TS, Ris),
        scorrilista(TS, TD, T).


% fisso il primo elemento (e la sua durata) e faccio le differenze con tutti gli altri elementi della lista
% le differenze vengono restituite in una lista
differenze(_, _, [], []).
differenze(S1, D1, [S2|TS2], [A|T]):-
        End1 #= S1+D1,
        A #= abs(S2-End1),
        differenze(S1, D1, TS2, T).


% est_lct(Lstart, Ltask)
est_lct([],[]).
est_lct([Start|Tstart], [task(ID, EST, LCT, D)|Ttask]):-
        % impongo i vincoli sul tempo
        Start #>= EST,
        Start + D #=< LCT,
        % chiamata ricorsiva
        est_lct(Tstart, Ttask).

% L = [8, 5, 13, 19, 3, 1]
% Yes (0.01s cpu)