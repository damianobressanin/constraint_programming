% Damiano Bressanin 138075
% esame 05/07/2017

:- lib(fd).
:- lib(fd_global).
:- lib(listut).

:- [pack_inst].

esame(Ldec) :-
        % leggo i dati e preparo le liste
        installed(Linstallati),
        package(Lpacchetti),
        
        findall([Pkt1, Pkt2], requires(Pkt1, Pkt2), Lrichiesti),
        
        findall([Pkt1, Pkt2], conflict(Pkt1, Pkt2), Lconflitti),
        
        findall(P, install(P), Linstallare),
        
        % la lista decisionale sui pacchetti deve essere lunga come il numero di pacchetti totale
        length(Lpacchetti, Npacchetti),
        length(Ldec, Npacchetti),
        % un pacchetto viene installato (1) oppure non viene installato (0)
        Ldec::0..1,
        
        % i pacchetti richiesti dall'utente devono essere presenti nella soluzione
        vincolo_richiesti(Linstallare, Ldec),
        
        % installo le dipendenze
        vincolo_dipendenze(Lrichiesti, Ldec),
        
        % gestisco i conflitti
        vincolo_conflitti(Lconflitti, Ldec),
        
        % conto il numero di installazioni e disinstallazioni effettuate
        conta_cambiamenti(Linstallati, Ldec, Costo),
        
        % minimizzo
        minimize(labeling(Ldec), Costo).
        
        






        
        
% vincolo che scorre la lista dei pacchetti da installare e impone che ci siano nella lista finale
vincolo_richiesti([], _).
vincolo_richiesti([H|T], Ldec) :-
        nth1(H, Ldec, 1),
        vincolo_richiesti(T, Ldec).
        

% Lrichiesti è una lista di liste
vincolo_dipendenze([], _).
vincolo_dipendenze([[X,Y]|T], Ldec) :-
        % leggo se ci sono o meno i pacchetti 
        nth1(X, Ldec, VX),
        nth1(Y, Ldec, VY),
        % vincolo importantissimo:
        % se X è installato allora Y deve essere installato
        % se X non è installato allora Y può essere installato oppure no
        % il vincolo "minore o uguale" con i valori a 0 e 1 mappa alla perfezione questo vincolo
        VX #<= VY,
        vincolo_dipendenze(T, Ldec).
        

% Lconflitti è una lista di liste
% vincolo_conflitti(Lconflitti, Ldec),
vincolo_conflitti([],_).
vincolo_conflitti([[X,Y]|T], Ldec) :-
        nth1(X, Ldec, VX),
        nth1(Y, Ldec, VY),
        % se X è installato insieme ad Y allora la loro somma fa 2
        % se solo uno dei due pacchetti è presente allora il vincolo è rispettato
        VX + VY #<= 1,
        vincolo_conflitti(T, Ldec).
        
        
% conta_cambiamenti(Linstallati, Ldec, Contatore).
conta_cambiamenti([],[],0).
conta_cambiamenti([H1|T1], [H2|T2], Contatore) :-
        H1 #\= H2 #<=> B,
        Contatore #= Contatore1 + B,
        conta_cambiamenti(T1, T2, Contatore1).
