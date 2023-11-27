rollDice(X):-
    random(1,7,Result),
    X is Result.

roll2Dices(X):- 
    rollDice(_1), rollDice(_2), X is _1 + _2.