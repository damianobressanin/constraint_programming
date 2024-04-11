package([1,2,3,4,5,6,7,8,9,10]).
installed([1,0,0,0,1,1,0,1,0,0]).
requires(1,2).
requires(3,4).

conflict(4,2).
conflict(5,4).

install(3).

