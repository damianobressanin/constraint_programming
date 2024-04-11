:- lib(fd).
:- lib(fd_global).
:- [impegni].




esame(L) :- 
        length(L,30),
        L :: 1..4,
        impegni_genitori(L,1),
        
        occurrences(1, L, GiorniPadre),
        GiorniPadre :: 0..4,
        
        occurrences(2, L, GiorniMadre),
        GiorniMadre :: 0..6,
        
        occurrences(4, L, GiorniTata),
        
        Costo #= 100*IscrittoAsilo+50*GiorniTata,
        
        [PrimoGiornoAsilo, UltimoGiornoAsilo]::1..30,
        
        IscrittoAsilo::0..1,
        
        asilo(L, 1, PrimoGiornoAsilo, UltimoGiornoAsilo, IscrittoAsilo),
        
        UltimoGiornoAsilo - PrimoGiornoAsilo #< 7,
        
        append(L, [PrimoGiornoAsilo, UltimoGiornoAsilo], Variabili),
        min_max(labeling(Variabili), Costo).
        
        
        
        
impegni_genitori([], _).
impegni_genitori([H|T], Giorno) :-
        findall(Genitore, impegno(Genitore, Giorno), GenitoriImpegnati),
        elimina_valori(H, GenitoriImpegnati),
        Giorno1 is Giorno+1,
        impegni_genitori(T, Giorno1).


elimina_valori(_,[]).
elimina_valori(X, [H|T]) :- 
        X #\= H,
        elimina_valori(X, T).
       
        
asilo([], _, _, _, _).
asilo([H|T], N, Primo, Ultimo, IscrittoAsilo):-
        H#=3 #<=> VaAsiloGiornoN,
        VaAsiloGiornoN #=< IscrittoAsilo,
        Primo #=< N #<=> InizioAsiloPrimaDelGiornoN,
        Ultimo #>= N #<=> TerminaAsiloDopoIlGiornoN,
        VaAsiloGiornoN #=< InizioAsiloPrimaDelGiornoN,
        VaAsiloGiornoN #=< TerminaAsiloDopoIlGiornoN,
        
        N1 is N+1,
        asilo(T, N1, Primo, Ultimo, IscrittoAsilo).





