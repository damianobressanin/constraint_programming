% DAMIANO BRESSANIN 138075

/*
Nomi Bambini:
innocente = 0     colpevole = 1
A = Aldo
B = Bruno
C = Carlo
D = Dario
E = Elio
F = Franco


Variabili che memorizzano il numero di verità delle affermazioni:
Se V = 1 allora il bambino ha detto esattamente 1 verità (ha nominato 1 innocente ed 1 colpevole);
Se V = 0 allora il bambino ha detto esattamente 0 verità (ha nominato 2 innocenti).

VA = Verità Aldo
VB = Verità Bruno
...
VE = Verità Elio

Inizialmente avevo messo anche VF ma dato che Franco è assente (e quindi non dice nulla) non ha senso metterla e sarebbe un errore.

*/


/*
VARIABILI:
- A,B,C,D,E,F rappresentano i bambini e indicano se sono colpevoli oppure innocenti (valore booleano).
- VA,VB,VC,VD,VE rappresentano il contatore di accuse corrette nelle frasi dette dai bambini.


DOMINI:
- Le variabili dei bambini sono di tipo booleano, quindi il dominio è [0,1].
- Inizialmente le variabili che rappresentano i contatori di accuse corrette le avevo messe con dominio [0,1,2]. Nel testo c'è scritto che 4 bambini hanno nominato 1 innocente ed 1 colpevole e che 1 bambino ha nominato 2 innocenti. Quindi il valore massimo di cose vere dette dai bambini è minimo 0 e massimo 1. Quindi il dominio è [0,1].


VINCOLI:
- Contatore di verità di una frase di un bambino = numero di colpevoli individuati.
- Esattamente 4 bambini hanno nominato di sicuro 1 colpevole.
- Esattamente 2 bambini sono colpevoli.
*/


:- lib(fd).
marmellata(A,B,C,D,E,F, VA,VB,VC,VD,VE) :-

         % Metto i domini alle variabili
         [A,B,C,D,E,F] :: [0,1],
         [VA,VB,VC,VD,VE] :: [0,1],

         % Aldo dice "Dario ed Elio"
         D + E #= VA,
         
         % Bruno dice "Carlo e Franco"
         C + F #= VB,
         
         % Carlo dice "Franco ed Elio"
         F + E #= VC,
         
         % Dario dice "Aldo ed Elio"
         A + E #= VD,
         
         % Elio dice "Carlo e Bruno"
         C + B #= VE,
         
         % Franco è assente
         % ---
         
         % dal testo si sa che esattamente 4 bambini hanno nominato di sicuro 1 innocente ed 1 colpevole
         VA + VB + VC + VD + VE #= 4,
         
         % dal testo si sa che esattamente 2 bambini hanno rubato la marmellata
         A + B + C + D + E + F #= 2,
         
         labeling([A,B,C,D,E,F, VA,VB,VC,VD,VE]).