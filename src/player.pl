/* DYNAMIC VARIABLE */
:- dynamic(nbPlayer/1).         /* player numbers */
:- dynamic(player/1).           /*  */
:- dynamic(unplacedSoldier/2).   /* playerName,  soldierCount*/
:- dynamic(turnPlayer/2).
nbPlayer(4).
turnPlayer(suta,1).
turnPlayer(mahew,2).
turnPlayer(adril,3).
turnPlayer(berto,4).
/* setUnplacedSoldier */
setUnplacedSoldier(PlayerName, SoldierCount) :- retract(unplacedSoldier(PlayerName, _)), assertz(unplacedSoldier(PlayerName, SoldierCount)),!.

/* check if the player lose, I.S any, F.S do nothing if player 
    not lose and delete the player and give message if the player lose */
checkLose(Player) :- 
            ownedTeritories(Player, TerList), isEmpty(TerList), 
            retract(unplacedSoldier(Player, _)) retract(player(Player)),
            retract(listName(Player)),
            format('Jumlah wilayah player ~w  0.', [Player]),
            format('Player ~w keluar dari permainan!',[Player]).

/* check if the player win */
checkWin(Player) :- 
            ownedTeritories(Player, TerList), listLength(TerList, TerCount),
            TerCount is 24, retractall(player(_)), retractall(listName(Player)), 
            retractall(isInit(_)), retractall(isPlayTheGame(_)),
            format('Player ~w telah menguasai dunia', [Player]).

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
    checkInputPlayer(X,Name),
    allOwnedContinent(Name,Continents),
    write('Nama           : '), write(Name),nl,nl,
    (member('asia',Continents) ->
        displayOwnContinent(Name,'asia')
    ;   write('')
    ),
    (member('europe',Continents) ->
        displayOwnContinent(Name,'europe')
    ;   write('')
    ),
    (member('north_america',Continents) ->
        displayOwnContinent(Name,'north_america')
    ;   write('')
    ),
    (member('south_america',Continents) ->
        displayOwnContinent(Name,'south_america')
    ;   write('')
    ),
    (member('africa',Continents) ->
        displayOwnContinent(Name,'africa')
    ;   write('')
    ),
    (member('australia',Continents) ->
        displayOwnContinent(Name,'australia')
    ;   write('')
    ),!.



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
