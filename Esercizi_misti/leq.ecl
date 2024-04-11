% Damiano Bressanin 138075
/* nuovo vincolo che dice che A deve essere "less or equal" a B */


:- lib(fd).

leq(A,B):-
	dvar_domain(A,DomA),
	dvar_domain(B,DomB),
	
	% cerco il massimo valore dei dominio di A
	dom_range(DomA, MinA, MaxA), %MaxA non viene usata
	
	% rimuovo tutti i valori di B che sono più piccoli del minimo di A
	dvar_remove_smaller(B, MinA),
	
	% cerco il massimo valore dei dominio di B
	dom_range(DomB, MinB, MaxB), %MinB non viene usata
	
	% devo eliminare dal dominio di A i valori più grandi del massimo del dominio di B
	dvar_remove_greater(A, MaxB),
	
	/*
	Sarebbe efficiente fare in modo di togliere il vincolo dal Constraint Store una volta che ho cose ground perché non può più fare propagazione.
	L'unico modo di avere una struttura di controllo è quello di usare il predicato cut (!) ma quindi devo creare un predicato nuovo a parte che si chiamerà sospendi(A,B).
	*/
	sospendi(A,B).
	
/*
Predicato che serve per andare a controllare se si può sospendere il vincolo.
*/
sospendi(A,B) :- nonvar(A), !.
sospendi(A,B) :- nonvar(B), !.
sospendi(A,B) :- suspend(leq(A,B), 5, [A->min, B->max]).
