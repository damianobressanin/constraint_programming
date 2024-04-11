% esercizio slide 109 da logica a clp

:-lib(fd).

diversi([_]):-!.

diversi([A,B|T]):- A #\= B, diversi([B|T]).
