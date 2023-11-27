/* DYNAMIC VARIABLE */
:- dynamic(nbPlayer/1).         /* player numbers */
:- dynamic(player/1).           /*  */
:- dynamic(currentTurn/1).      /* 0 - nbPlayer */
:- dynamic(unplacedSoldier/2).   /* playerName,  soldierCount*/
:- dynamic(turnPlayer/2).

/* setUnplacedSoldier */
setUnplacedSoldier(PlayerName, SoldierCount) :- retract(unplacedSoldier(PlayerName, _)), assertz(unplacedSoldier(PlayerName, SoldierCount)),!.

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

/* bonus soldier from owned Continents priviledge */
bonusSoldierFromContinents(Owner,Bonus):-
    allOwnedContinent(Owner, Continents),
    (member(asia,Continents) ->
        BonusAsia = 5
    ;   BonusAsia = 0
    ),
    (member(europe, Continents) ->
        BonusEurope = 3
    ;   BonusEurope = 0
    ),
    (member(north_america, Continents) ->
        BonusNorthAmerica = 3
    ;   BonusNorthAmerica = 0
    ),
    (member(south_america, Continents) ->
        BonusSouthAmerica = 2
    ;   BonusSouthAmerica = 0
    ),
    (member(africa, Continents) ->
        BonusAfrica = 2
    ;   BonusAfrica = 0
    ),
    (member(australia, Continents) ->
        BonusAustralia = 1
    ;   BonusAustralia = 0
    ),
    Bonus is BonusAsia + BonusEurope + BonusNorthAmerica + BonusSouthAmerica + BonusAfrica + BonusAustralia, 
    !.

/* bonus soldier from sum Territory owned */
bonusSoldierFromTerritory(Owner,Bonus):-
    countOwnedTerritories(Owner, Count),
    (Count mod 2 = 0 ->
        Bonus is Count / 2
    ;   Bonus is (Count - 1)/ 2
    ),!.

/* return Player name from input */

/* check Player Detail */
checkPlayerDetail(X):-
    checkInputPlayer(X, Name),
    allOwnedContinent(Name,Continents), 
    countOwnedTerritories(Name, TerritoryOwn),
    countPlacedSoldier(Name,NbPlacedSoldier),
    unplacedSoldier(Name,NbUnplacedSoldier),
    write('Nama                   : '),write(Name),nl,
    length(Continents, NbContinents),
    (NbContinents = 0 ->
        write('Benua                  : Tidak ada'),nl
    ;   write('Benua                  : '),writeList(Continents),nl
    ),
    write('Total Wilayah          : '),write(TerritoryOwn),nl,
    write('Total Tentara Aktif    : '),write(NbPlacedSoldier),nl,
    write('Total Tentara Tambahan : '),write(NbUnplacedSoldier),nl.


/* check Player Teritories */
checkPlayerTeritories(X):-
    nbPlayer(Count),
    ((X = p1 ; X = P1) , Count >= 1 ->
        findall(Player,turnPlayer(Player,1), PlayerName),
        write('Player P1')
    ; 
        ((X = p2 ; X = P2) , Count >= 2 ->
            findall(Player,turnPlayer(Player,2), PlayerName),
            write('Player P2')
        ;   
            ((X = p3; X = P3) , Count >= 3 ->
                findall(Player, turnPlayer(Player,3), PlayerName),
                write('Player P3')
            ;
                ((X = p4; X = P4), Count = 4 ->
                    findall(Player, turnPlayer(Player,4), PlayerName)
                    write('Player P4')
                ;
                    format('Masukkan input yang valid! (p1 - p~w)', Count), nl, !.
                ) 
            )
        )
    ),nl,nl.

/* check Incoming Troops Detail*/
checkIncomingTroops(X):-
    checkInputPlayer(X, Name),
    count

