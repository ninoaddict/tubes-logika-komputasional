/* Deklarasi Rule */
getElmt([], _, _) :- fail.
getElement([A|B], Idx, ELmt) :- 
    (Idx =:= 1, ELmt is A, !);
    (Idx =\= 1, Idx1 is Idx -1, getElement(B, Idx1, ELmt)).

insertFirst([], X, [X]).
insertFirst(OldList, X, NewList) :-
    NewList = [X | OldList].

deleteAt([_ | T], 0, T).
deleteAt([H | T], Index, List) :-
    I is Index - 1,
    deleteAt(T, I, A),
    List = [H | A].

deleteElmt([X|T], X, T).
deleteElmt([H | T], X, List) :-
    X =/= H, 
    deleteElmt(T, X, A),
    List = [H|A].

getIdx([A | B], E, Idx) :- 
    (E =:= A, Idx is 1, !); 
    (getIdx(B, E, IdxRes), Idx is IdxRes + 1).

isElmt([X | _], X, 1).
isElmt([_ | T], Elmt, Answer) :-
    isElmt(T, Elmt, A),
    Answer is A.

setElmt([], _, _, _) :- fail.
setElmt(_, I, _, _) :- I < 0, fail.
setElmt([_|Y], I, V, R) :- I is 0, !, R = [V|Y].
setElmt([X|Y], I, V, R) :- I1 is I - 1, setElmt(Y, I1, V, R1), R = [X|R1].

indexOf([], _, _) :- fail.
indexOf([X|_], El, R) :- X = El, !, R is 0.
indexOf([_|Y], El, R) :- indexOf(Y, El, R2), R is R2 + 1.

setElmt([_|T],1,Val,[Val|T]).
setElmt([H|T],Idx,Val,Res):- 
    Idx1 is Idx-1,
    setElmt(T,Idx1,Val,Res1),
    Res = [H|Res1].
