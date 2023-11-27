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

/* return Player name from input (check-check purpose) */
checkInputPlayer(X , Name):-
    nbPlayer(Count),nl,
    (((X = 'p1') , Count >= 1) ->
        findall(Player,turnPlayer(Player,1), PlayerName),
        write('Player P1')
    ;   (((X = 'p2') , Count >= 2) ->
            findall(Player,turnPlayer(Player,2), PlayerName),
            write('Player P2')
        ;   (((X = 'p3') , Count >= 3) ->
                findall(Player, turnPlayer(Player,3), PlayerName),
                write('Player P3')
            ;   (((X = 'p4'), Count = 4) ->
                    findall(Player, turnPlayer(Player,4), PlayerName),
                    write('Player P4')
                ;
                    format('Masukkan input yang valid! (p1 - p~w)', Count), nl, fail
                )
            )
        )
    ),nl,nl,
    getHeadList(PlayerName,Name).