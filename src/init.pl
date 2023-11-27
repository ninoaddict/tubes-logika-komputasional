:- dynamic(nbPlayer/1).
:- dynamic(traversal/1).
:- dynamic(listName/1).
:- dynamic(listDice/1).

startGame :- 
    retractall(nbPlayer(_)),
    retractall(traversal(_)),
    retractall(listName(_)),
    repeat,
    write('Masukkan jumlah pemain: '),
    read(NBPlayer),
    (validNBPlayer(NBPlayer) ->
        !
    ; 
        write('Mohon masukkan angka antara 2 - 4.\n'),
        fail
    ),
    assertz(nbPlayer(NBPlayer)),
    nl,
    retractall(traversal(_)),
    assertz(traversal(0)),
    retractall(listName(_)),
    assertz(listName([])),
    askPlayerNames(1, NBPlayer),
    repeat,
    retractall(listDice(_)), nl,
    assertz(listDice([])),
    InitNum is 1,
    (countPlayerDice(InitNum) ->
        listDice(ListDice),
        (isUnique(ListDice) -> 
            !
        ; 
            write('\nAda beberapa pemain yang mendapatkan gulungan dadu yang sama, pelemparan dadu diulang.\n'),
            fail
        )
    ; 
        true
    ),
    write('\nSuccess\n'), !.

validNBPlayer(N):- N > 1, N < 5, !.

askPlayerNames(N, Nb) :- 
    (N =< Nb -> 
        repeat,
            format('Masukkan nama pemain ~d: ', [N]),
            read(PlayerName),
            (isInList(PlayerName) -> (
                format('Nama pemain ~w sudah diambil.\n', [PlayerName]),
                fail
            ) ; (
                addPlayerName(PlayerName),
                N1 is N + 1,
                askPlayerNames(N1, Nb)
            )),
        ! ; true).

endAskPlayerName(N) :- nbPlayer(Nb), N =:= Nb, !.

addPlayerName(X) :- 
    retract(listName(L)),
    append(L, [X], Res),
    assertz(listName(Res)).
    
isInList(X) :- 
    listName(L),
    member(X, L).

countPlayerDice(N):- 
    nbPlayer(Nplayer), 
    (N =< Nplayer, 
    roll2Dices(X),
    listName(LisNem), 
    getName(LisNem, N, CurName),
    format('~w melempar dadu dan mendapatkan ~d.\n', [CurName, X]),
    retract(listDice(DiceList)),
    addEnd(DiceList, X, NewDice),
    assertz(listDice(NewDice)),
    N1 is N + 1,
    countPlayerDice(N1),
    !
    ; 
    true
    ).