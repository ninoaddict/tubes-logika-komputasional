/* DYNAMIC VARIABLE */
:- dynamic(nbPlayer/1).         /* player numbers */
:- dynamic(player/1).           /*  */
:- dynamic(currentTurn/1).      /* 0 - nbPlayer */
:- dynamic(unplacedSoldier/2)   /* playerName,  soldierCount*/

/* Still in Progress */
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

/* Still in Progress */
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

/* Access the front name of the queue*/
currentPlayer(X) :- player(X), !.

/* Move the front name to the back of the queue*/
dequeuePlayer(X) :- 
    retract(queueName(Name)),
    assertz(queueName(Name)),
    !.

/* Clear the player queue (used in the end of the game) */
clearPlayerQueue(X) :- 
    retractall(queueName(_)),!.