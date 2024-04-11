% Damiano Bressanin 138075

% per il caricamento di un file
:-["pazienti15.pl"].



% paziente(ID, OrarioMinimo, OrarioMassimo)
% distanza(Paziente1, Paziente2, Tempo)



:- lib(fd).
:- lib(fd_global).
:- import alldifferent/1 from fd_global.
:- lib(propia).
:- lib(listut).

tsptw(L,CostoTotale):-
                % carico tutti i pazienti per contarli
                findall(paziente(ID, OrarioMinimo, OrarioMassimo), paziente(ID, OrarioMinimo, OrarioMassimo), Linput),
                length(Linput, Npazienti),
                % aggiungo l'ospedale
                Npo #= Npazienti + 1,
                length(L, Npo),
                L::0..Npazienti,
                % non posso visitare due volte lo stesso paziente
                alldifferent(L),
                % parte dall'ospedale
                nth1(1,L, 0),
                
                vincolo_distanza(L, 0, CostoTotale),
                minimize(labeling(L), CostoTotale).
                

       
% vincolo_distanza(L, Costo_attuale, Costo_totale)

% caso base: il costo totale è dato dal costo accumulato durante il tragitto + il costo per ritornare all'ospedale
vincolo_distanza([Ultimo], Costo_attuale, Costo_totale):-
        distanza(Ultimo, 0, C_U0) infers most,
        Costo_totale #= C_U0 + Costo_attuale.

% caso ricorsivo:
vincolo_distanza([P1,P2|T], Costo_attuale, Costo_totale):-
        % trovo il costo per andare da un paziente al successivo
        distanza(P1,P2, Costo_p1p2) infers most,
        % aggiorno il tempo attuale
        Costo_aggiornato #= Costo_attuale+Costo_p1p2,
        
        % prendo la TW del paziente nel quale arrivo e impongo di essere nel range
        paziente(P2, Min, Max) infers most,
        Costo_aggiornato #>= Min,
        Costo_aggiornato #=< Max,
        
        %chiamata ricorsiva
        vincolo_distanza([P2|T], Costo_aggiornato, Costo_totale).
        