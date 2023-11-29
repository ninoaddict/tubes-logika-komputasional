/* DYNAMIC VARIABLE */
:- dynamic(nbPlayer/1).         /* player numbers */
:- dynamic(player/1).           /*  */
:- dynamic(unplacedSoldier/2).   /* playerName,  soldierCount*/
:- dynamic(turnPlayer/2).

/* setUnplacedSoldier */
setUnplacedSoldier(PlayerName, SoldierCount) :- retract(unplacedSoldier(PlayerName, _)), assertz(unplacedSoldier(PlayerName, SoldierCount)),!.

/* check if the player lose, I.S any, F.S do nothing if player 
    not lose and delete the player and give message if the player lose */
checkLose(Player) :- 
            ownedTeritories(Player, TerList), isEmpty(TerList), 
            nl, format('Jumlah wilayah player ~w 0.', [Player]), nl,
            format('Player ~w keluar dari permainan!',[Player]), 
            retract(nbPlayer(N)), N1 is N - 1, assertz(nbPlayer(N1)),
            retract(unplacedSoldier(Player, _)),
            retract(player(Player)), retract(listName(OldList)),  
            deleteStr(OldList, Player , NewListName), 
            assertz(listName(NewListName)),!.

/* check if the player win */
checkWin(Player) :- 
            nbPlayer(N), N =:= 1, 
            nl,  format('Player ~w telah menguasai dunia', [Player]), nl,
            retractall(player(_)), retractall(listName(_)), 
            retractall(isInit(_)), retractall(isPlayTheGame(_)), !.

/* Access the front name of the queue*/
currentPlayer(X) :- player(X), !.

/* bonus soldier from owned Continents priviledge */
bonusSoldierFromContinents(Owner,ListBonus):-
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
    appendList([BonusAsia,BonusEurope,BonusNorthAmerica,BonusSouthAmerica,BonusAfrica],BonusAustralia,ListBonus),!.

/* bonus soldier from sum Territory owned */
bonusSoldierFromTerritory(Owner,Bonus):-
    countOwnedTerritories(Owner, Count),
    (Count mod 2 =:= 0 ->
        Bonus is Count // 2
    ;   Bonus is (Count - 1 )// 2
    ),!.


/* check Player Detail */
checkPlayerDetail(X):-
    isPlayTheGame(_),
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
checkPlayerTerritories(X):-
    isInit(true),
    checkInputPlayer(X,Name),
    allOwnedContinent(Name,Continents),
    length(Continents,Count),
    write('Nama           : '), write(Name),nl,nl,
    (Count = 0 -> 
        write('Tidak ada wilayah Territory'),nl
    ;   true
    ),
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
    isPlayTheGame(_),
    checkInputPlayer(X, Name),
    countOwnedTerritories(Name,CountTerritories),
    bonusSoldierFromTerritory(Name,BonusTerritory),
    bonusSoldierFromContinents(Name,ListBonus),
    getElement(ListBonus,1,BonusAsia),   
    getElement(ListBonus,2,BonusEurope),   
    getElement(ListBonus,3,BonusNorthAmerica),   
    getElement(ListBonus,4,BonusSouthAmerica),   
    getElement(ListBonus,5,BonusAfrica),   
    getElement(ListBonus,6,BonusAustralia),
    sumUntil(ListBonus,5,BonusContinents),
    Bonus is BonusContinents + BonusTerritory,
    write('Nama                                 : '),write(Name),nl,
    write('Total Wilayah                        : '),write(CountTerritories),nl,
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
