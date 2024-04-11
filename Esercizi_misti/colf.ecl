% DAMIANO BRESSANIN 138075
% esercizio Colf con una variante


:-lib(fd).
:-lib(fd_global).
:-lib(edge_finder3).

% somma gli elementi di due liste di lunghezza uguale. Lo uso per calcolare endtime
somma_liste([],[],[]).
somma_liste([H1|T1], [H2|T2], [H|T]):- H #= H1+H2, somma_liste(T1,T2,T).



% Task: lavare, asciugare, stirare, piatti, pizza, pulizia


csp(L):-
        % lista L di start time
        L=[Lavare, Asciugare, Stirare, Piatti, Impasto, Preriscaldamento, Cottura, Pulizia],
        L::0..200,
        % non ho messo dentro anche "Lievitazione" perché la definisco dopo
        
        % durata delle attività presenti in L
        Durata=[45,60,60,40,15,5,15,120],
        
        % consumi energetici delle attività in L
        Consumi_energia=[1700,1000,2000,1800,0,2000,2000,0],
        
        % attività manuali che possono essere svolte solo dalla colf
        Colf=[0,0,1,0,1,0,0,1],
        
        % soglia massima di consumo elettrico
        Max_energia#=3000,
        
        % soglia massima di colf disponibili
        Max_colf#=1,
        
        % tempo massimo a disposizione per fare tutto
        Max_durata#=200,
        
        % vincoli cumulative sulle attività
        % cumulative([S1, ..., Sn], [D1, ..., Dn], [R1, ..., Rn], L)
        cumulative(L, Durata, Consumi_energia, Max_energia),
        cumulative(L, Durata, Colf, Max_colf),
        
        % sistemiamo la lievitazione che ha una durata variabile
        Cottura-(Impasto+15) #>=60,
        Cottura-(Impasto+15) #<= 120,
        
        somma_liste(L,Durata,Endtime),
        maxlist(Endtime, Fine),
        Fine #<= Max_durata,
        
        
        % sistemo le precedenze
        Asciugare #>= Lavare+45,
        Stirare #>= Asciugare+60,
        
        Cottura #>= Preriscaldamento+5,
        
        % vincolo ridondante
        Cottura #>= Impasto+15,
        
        
        fd_global:alldifferent(L),
        
        min_max(labeling(L),Fine).