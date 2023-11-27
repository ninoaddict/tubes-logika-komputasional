:-dynamic(queueName/1).

frontName(X) :- queueName(X),!.

enqueueName:-
    read(Name),
    assertz(queueName(Name)).

dequeueName:-
    retract(queueName(Name)),
    write(Name),
    assertz(queueName(Name)), !.

addEnd([], X, [X]):-!.
addEnd([A|B], X, [A|D]):- addEnd(B,C,D).

clearQueue:-
    retractall(queueName(List)),
    write([List]),!.