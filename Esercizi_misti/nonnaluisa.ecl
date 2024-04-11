% DAMIANO BRESSANIN 138075 11/08/2023
% Esercizio "la torta di nonna Luisa"


% VARIABILI: il problema è composto da 3 azioni che chiameremo "task"
% chi compie l'azione:          Task_Nonna, Task_Cane, Task_Torta
% quando compie l'azione:       Inizio_Task_Nonna, Inizio_Task_Cane, Inizio_Task_Torta


% DOMINI:
% Task_Nonna, Task_Cane, Task_Torta hanno come dominio [1,2,3]
% 1 --> Carletto
% 2 --> Pierino
% 3 --> Tommaso

% Inizio_Task_Nonna, Inizio_Task_Cane, Inizio_Task_Torta hanno come dominio 0..20
% l'ho scelto così in modo arbitrario, ragionando meglio sul problema si potrebbe abbassare un po'

% VINCOLI
% ogni bambino può fare solo un task
% Si può iniziare a distrarre il cane solo da un minuto dopo che la nonna abbia iniziato a parlare e almeno 1 minuto prima che finisca
% la sottrazione della torta deve essere effettuata mentre sia il cane sia la nonna sono distratti


:- lib(fd).
:- lib(fd_global).
:- import alldifferent/1 from fd_global.

% Variabili
nonna(Task_Nonna, Task_Cane, Task_Torta, Inizio_Task_Nonna, Inizio_Task_Cane, Inizio_Task_Torta):-
        
        % Domini
        [Task_Nonna, Task_Cane, Task_Torta] :: 1..3,
        [Inizio_Task_Nonna, Inizio_Task_Cane, Inizio_Task_Torta] :: 0..20,
        
        % Vincoli
        alldifferent([Task_Nonna, Task_Cane, Task_Torta]),
        
        element(Task_Nonna, [5,3,2], Durata_Task_Nonna),
        element(Task_Cane, [4,2,3], Durata_Task_Cane),
        element(Task_Torta, [2,5,4], Durata_Task_Torta),
        
        Inizio_Task_Cane #>= Inizio_Task_Nonna + 1,
        Inizio_Task_Cane #<= (Inizio_Task_Nonna+Durata_Task_Nonna) - 1,
        
        Inizio_Task_Torta #>= Inizio_Task_Nonna,
        (Inizio_Task_Torta+Durata_Task_Torta) #<= (Inizio_Task_Nonna+Durata_Task_Nonna),
        
        Inizio_Task_Torta #>= Inizio_Task_Cane,
        (Inizio_Task_Torta+Durata_Task_Torta) #<= (Inizio_Task_Cane+Durata_Task_Cane),
        
        
        labeling([Task_Nonna, Task_Cane, Task_Torta, Inizio_Task_Nonna, Inizio_Task_Cane, Inizio_Task_Torta]).
        
        
        
        
        
        
        