:- dynamic(queueName/1).

enqueueName :-
    read(Name),
    assertz(queueName(Name)).

dequeueName :-
    retract(queueName(Name)),
    write(Name),
    assertz(queueName(Name)), !.

addEnd([], X, [X]) :- !.
addEnd([A|B], X, [A|D]) :- addEnd(B, X, D).

clearQueue :-
    retractall(listName(_)),
    ListNm = [],
    assertz(listName(ListNm)),
    queueName(_),
    repeat,
    retract(queueName(Name)),
    retract(listName(ListName)),
    addEnd(ListName, Name, AddedList),
    assertz(listName(AddedList)),
    \+queueName(_),
    !, listName(ListNeme), write(ListNeme).
    

readNumber:-
    repeat, write('Masukkan banyak pemain: '),
    read(Angka),
    Angka >= 2, Angka =< 4, !.