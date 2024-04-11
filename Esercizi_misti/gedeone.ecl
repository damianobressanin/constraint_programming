% Es slide 87 - da_logica_a_CLP.pdf

:- lib(fd).

csp(Dario,Umberto,Gedeone) :-

    %definizione domini
    Dario::1..100, Umberto::1..100, Gedeone::1..100, 
    Gedeone_nelPassato::1..100, Dario_nelPassato::1..100,

    %vincoli prima frase
    Dario #= Dario_nelPassato * 6 - 11 , Dario_nelPassato * 6 #=  Gedeone_nelPassato,
    %vincoli seconda frase
    Umberto #= Dario +3, Umberto #= Gedeone - Dario -3,
    %vincoli impliciti
    Dario_nelPassato - Gedeone_nelPassato #= Dario - Gedeone,

    labeling([Dario,Umberto,Gedeone]).