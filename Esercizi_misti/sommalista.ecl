% Si scriva un predicato CLP(FD) che impone che una variabile S sia la somma di una lista di variabili con dominio
% ESEMPIO: ?- sommalista([A,B,C],S).


:- lib(fd).
:- lib(fd_global).
:- lib(propia).
% ho modificato l'esercizio per testare i pari e i dispari e altre cose

sommalista([A,B,C,D],S):-
        [A,B,C,D]::(-10)..10,
        
        S #= (A+B+C+D),
        
        C #= 2*_, % modo per dire che C deve essere pari
        
        B #= 7*_,
        
        A#=2*_+1, % modo per dire che A deve essere dispari
        
        D #= 3*_, % modo per dire che D deve essere multiplo di 3
        
        fd_global:alldifferent([A,B,C,D]),
        
        infers(abs_val(C, D), most), % D è il valore assoluto di C
        
        %min_max(labeling([A,B,C,D]), S*(+1)).
        labeling([A,B,C,D]).
        
abs_val(X,A):-X#>0, A#=X.
abs_val(X,A):-X#<0, A#= -X.