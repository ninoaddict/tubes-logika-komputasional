:- dynamic(nbPlayer/1).
:- dynamic(traversal/1).
:- dynamic(listName/1).

startGame :- 
    retractall(nbPlayer(_)),
    retractall(traversal(_)),
    retractall(listName(_)),
    repeat,
    write(' Masukkan jumlah pemain: '),
    read(NBPlayer),
    (validNBPlayer(NBPlayer) ->
        !
    ; 
        write(' Mohon masukkan angka antara 2 - 4.\n'),
        fail
    ),
    assertz(nbPlayer(NBPlayer)),
    nl,
    retractall(traversal(_)),
    assertz(traversal(0)),
    retractall(listName(_)),
    assertz(listName([])),
    askPlayerNames(1, NBPlayer),
    write('Success\n').

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
