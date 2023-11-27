/* DYNAMIC VARIABLE */
:- dynamic(nbPlayer/1). 
:- dynamic(player/1).           /*  */
:- dynamic(currentTurn/1).      /* 0 - nbPlayer */
:- dynamic(unplacedSoldier/2)   /* playerName,  soldierCount*/

initiating :-
    nl,
    checkPlayer,
    nbPlayer(X),
    write('Pemain: '),
    write(X).

readPlayerNumber:-
    write('Masukkan jumlah pemain: '),
    read(X),
    (X >= 2, X =< 4 ->
        retractall(nbPlayer(_)),
        assertz(nbPlayer(X)),
        nl
    ;   write('Mohon masukkan angka antara 2 - 4.'),
        nl,
        checkPlayer
    ).

readPlayerNames:-
    _N is 4,
    _i is 1,
    repeat,
    write('Masukkan nama pemain '),
    write(_i),
    write(': '),
    nl,
    _i is _i + 1,
    endOfReadPlayerName(_i, _N).
    
endOfReadPlayerName(N, N).