:- dynamic(traversal/1).
:- dynamic(listName/1).
:- dynamic(listDice/1).

startGame :- 
    retractall(nbPlayer(_)),
    retractall(traversal(_)),
    retractall(listName(_)),
    repeat,
    write('\nMasukkan jumlah pemain: '),
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
        (isMaxValid(ListDice) -> 
            !
        ; 
            write('\nAda beberapa pemain dengan gulungan dadu terbesar yang sama, pelemparan dadu diulang.\n'),
            fail
        )
    ; 
        true
    ),
    handleOrder, nl,
    write('Urutan pemain:'), Order is 1,displayOrder(Order),
    currentPlayer(CurP),
    format('~w dapat memulai terlebih dahulu.\n', [CurP]).

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
    roll2Dices(DiceNum),
    listName(LisNem), 
    getName(LisNem, N, CurName),
    format('~w melempar dadu dan mendapatkan ~d.\n', [CurName, DiceNum]),
    retract(listDice(DiceList)),
    addEnd(DiceList, DiceNum, NewDice),
    assertz(listDice(NewDice)),
    N1 is N + 1,
    countPlayerDice(N1), !
    ; true
    ),
    !.

handleOrder:-
    retractall(player(_)), retractall(turnPlayer(_,_)),
    listDice(LD),
    max(LD, Max),
    getIndex(LD, Max, Index),
    listName(LN),
    setPlayerOrder(Index, LN, 1),!.

setPlayerOrder(1, [], _) :-!.
setPlayerOrder(1, [A|B], Num):-
    assertz(player(A)), assertz(turnPlayer(A,Num)),
    Num1 is Num + 1, setPlayerOrder(1, B, Num1), !.
setPlayerOrder(Idx, [A|B], Num):-
    Idx1 is Idx -1, addEnd(B,A,Res),setPlayerOrder(Idx1,Res,Num), !.

displayOrder(N):-
    nbPlayer(Nplayer),
    (N =< Nplayer,
    retract(player(Name)),
    (N =\= Nplayer -> (
        format(' ~w -', [Name])
    );(
        format(' ~w\n', [Name])
    )),
    assertz(player(Name)),
    N1 is N+1, displayOrder(N1); true),
    !. 