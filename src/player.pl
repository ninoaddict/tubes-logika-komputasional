/* DYNAMIC VARIABLE */
:- dynamic(nbPlayer/1).
:- dynamic(player/2).
:- dynamic(currentTurn/1).

initiating :-
    nl,
    checkPlayer,
    nbPlayer(X),
    write('Pemain: '),
    write(X).

checkPlayer:-
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
