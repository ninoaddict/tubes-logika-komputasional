isIn([A|B], E, Idx):-
    (E == A, Idx is 1, !);
    (E \== A, isIn(B, E, IdxRes), Idx is IdxRes + 1).
