/* Roll Dice */
rollDice(X):-
    random(1,7,Result),
    X = Result.

/* Roll 2 Dice */
roll2Dices(X):- 
    rollDice(_1), rollDice(_2), X is _1 + _2.

/* Convert Integer to String */
integerToString(X, Y) :- X < 10, number_codes(X, Codes), atom_codes(String, Codes), atom_concat('00', String, Y), !.
integerToString(X, Y) :- X < 100, number_codes(X, Codes), atom_codes(String, Codes), atom_concat('0', String, Y), !.
integerToString(X, Y) :- Y is X,!. 
