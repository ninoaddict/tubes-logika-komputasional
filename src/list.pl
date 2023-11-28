/* Deklarasi Rule */
getElement([A|B], I, Elmt):- I =:= 1, Elmt is A,!; I =\= 1, I1 is I-1,getElement(B,I1,Elmt).

/* True jika isEmpty  */
isEmpty([]).

insertFirst([], X, [X]).
insertFirst(OldList, X, NewList) :-
    NewList = [X | OldList].

addEnd([], X, [X]):- !.
addEnd([A|B], C, [A|D]) :- addEnd(B,C,D).

deleteAt([_ | T], 1, T):- !.
deleteAt([H | T], Index, List) :-
    I is Index - 1,
    deleteAt(T, I, A),
    List = [H | A].

deleteElmt([X|T], X, T).
deleteElmt([H | T], X, List) :-
    X =\= H, 
    deleteElmt(T, X, A),
    List = [H|A].

min([X], X).
min([A|B], Min):- min(B,Min1), A >= Min1,!,Min is Min1.
min([A|B], Min):- min(B,Min1), A < Min1,!,Min is A. 
/* 1.B */
max([X], X).
max([A|B], Max):- max(B,Max1), A =< Max1,!,Max is Max1.
max([A|B], Max):- max(B,Max1), A>Max1,!,Max is A.

getIndex([A|B], E, Index):- E =:= A, Index is 1,!; E=\=A, getIndex(B,E,Index1), Index is Index1+1.

isIn([A|B], E, Idx):-
    (E == A, Idx is 1, !);
    (E \== A, isIn(B, E, IdxRes), Idx is IdxRes + 1).

getName([A|B], I, Elmt):- I =:= 1, Elmt = A,!; I =\= 1, I1 is I-1,getName(B,I1,Elmt).

setName([_|B], 1, Num, [Num|B]):- !.
setName([A|B], Index, Num, [A|C]) :- Index > 1, Indexx is Index-1, setName(B,Indexx, Num, C).

swapName(X,I, I, X) :- !.
swapName(X,I1, I2, Result) :-
    getName(X,I1,Elmt1),
    getName(X,I2,Elmt2),
    setName(X,I2,Elmt1,Res1),
    setName(Res1,I1,Elmt2,Result).

isElmt([X | _], X, 1).
isElmt([_ | T], Elmt, Answer) :-
    isElmt(T, Elmt, A),
    Answer is A.

isUnique([]):-!.
isUnique([A|B]):- \+getIndex(B, A, _), isUnique(B).

isMaxValid(X):-
    max(X, Max),
    getIndex(X, Max, Index),
    deleteAt(X, Index, Res),
    max(Res, Imax),
    Max =\= Imax, !.

setElement([_|B], 1, Num, [Num|B]):- !.
setElement([A|B], Index, Num, [A|C]) :- Index > 1, Indexx is Index-1, setElement(B,Indexx, Num, C).

indexOf([], _, _) :- fail.
indexOf([X|_], El, R) :- X = El, !, R is 0.
indexOf([_|Y], El, R) :- indexOf(Y, El, R2), R is R2 + 1.


swap(X,I, I, X) :- !.
swap(X,I1, I2, Result) :-
    getElement(X,I1,Elmt1),
    getElement(X,I2,Elmt2),
    setElement(X,I2,Elmt1,Res1),
    setElement(Res1,I1,Elmt2,Result).

sortList([],[]):-!.
sortList(X,Result):-
    min(X, Min),
    getIndex(X,Min,Index),
    swap(X,1,Index, Res),
    [A|B] = Res,
    sortList(B,ResultTT),
    Result = [A|ResultTT],!.

sortName([],[],[],[]):-!.
sortName(LDice, LName, ResD, ResL):-
    max(LDice, Min),
    getIndex(LDice, Min, Idx),
    swap(LDice, 1, Idx, Res),
    swapName(LName, 1, Idx, ResName),
    [A|B] = Res,
    [An|Bn] = ResName,
    sortName(B, Bn, Result, ResultN),
    ResD = [A|Result],
    ResL = [An|ResultN], !.

/* sum list of integer until Index IndexUntil (Index start from 0)*/
sumUntil([], _, 0) :- !.
sumUntil([X|_], 0, X) :- !.
sumUntil([X|Y], IndexUntil, Res) :- IndexNext is IndexUntil - 1, sumUntil(Y, IndexNext, Res2), Res is Res2 + X.

/* write List without bracket -> ex : elmt1, elmt2, ... elmt*/
writeList([Head|[]]):-
    write(Head).
writeList([Head|Tail]):-
    write(Head),
    write(', '),
    writeList(Tail).

/* Return the length of the list */
listLength([], X) :- X is 0, !.
listLength([_|T], X) :- listLength(T, X1), X is X1 + 1, !.

/* Return the Idx-th element of the list*/
getElementString([], _, _) :- fail.
getElementString([A|B], Idx, ELmt) :- 
    (Idx =:= 1, ELmt = A, !);
    (Idx =\= 1, Idx1 is Idx -1, getElementString(B, Idx1, ELmt)).

/* Return head of the list if list only one element (important for checkPlayerDetail)  */
getHeadList([A|[]], Result):-
    Result = A.

/* append element to list */
appendList([], Element, [Element]).
appendList([Head|Tail],Element,[Head|Result]):-
    appendList(Tail,Element,Result).