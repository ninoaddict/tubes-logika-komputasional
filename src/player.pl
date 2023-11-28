/* DYNAMIC VARIABLE */
:- dynamic(nbPlayer/1).         /* player numbers */
:- dynamic(player/1).           /*  */
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
    countOwnedTerritories(Name,CountTerritories),
    bonusSoldierFromTerritory(Name,BonusTerritory),
    bonusSoldierFromContinents(Name,ListBonus),
    getElement(ListBonus,0,BonusAsia),   
    getElement(ListBonus,1,BonusEurope),   
    getElement(ListBonus,2,BonusNorthAmerica),   
    getElement(ListBonus,3,BonusSouthAmerica),   
    getElement(ListBonus,4,BonusAfrica),   
    getElement(ListBonus,5,BonusAustralia),
    sumUntil(ListBonus,5,BonusContinents),
    Bonus = BonusContinents + BonusTerritory,
    write('Nama                                 : '),write(Name),nl,
    write('Total Wilayah                        : '),write(CountTerritory),nl,
    write('Jumlah tentara tambahan dari wilayah : '),write(BonusTerritory),nl,
    (BonusAsia =\= 0 -> 
        write('Bonus benua asia                     : '),write(BonusAsia),nl
    ;   write('')
    ),
    (BonusEurope =\= 0 -> 
        write('Bonus benua europe                   : '),write(BonusEurope),nl
    ;   write('')
    ),
    (BonusNorthAmerica =\= 0 -> 
        write('Bonus benua north america            : '),write(BonusNorthAmerica),nl
    ;   write('')
    ),
    (BonusSouthAmerica =\= 0 -> 
        write('Bonus benua south america            : '),write(BonusSouthAmerica),nl
    ;   write('')
    ),
    (BonusAfrica =\= 0 -> 
        write('Bonus benua africa                   : '),write(BonusAfrica),nl
    ;   write('')
    ),
    (BonusAustralia =\= 0 -> 
        write('Bonus benua australia                : '),write(BonusAustralia),nl
    ;   write('')
    ),
    write('Total tentara tambahan               : '),write(Bonus),!.
