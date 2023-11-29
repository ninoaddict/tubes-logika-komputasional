endTurn:-
    currentPlayer(Name),
    write('Player '), write(Name), write(' mengakhiri giliran.'),
    nl,nl,
    retract(queueName(Name)),
    assertz(queueName(Name)),
    currentPlayer(NextName),
    riskEndBeforeTurn(LL),
    riskCard(NextName, X),
    (getIndex(LL, X, _) ->
        retract(riskCard(NextName,_)),
        retract(riskTaken(_))
        ;
        true
    ),
    write('Sekarang giliran Player '), write(NextName), write('!'),
    nl,
    bonusSoldierFromContinents(NextName, ListBonus),
    bonusSoldierFromTerritory(NextName,BonusTerritory),
    sumUntil(ListBonus,5,BonusContinents),
    (riskCard(NextName,3) ->
        write('Player '),write(NextName),write(' mendapatkan AUXILIARY TROOPS!'),nl,
        Bonus is (BonusContinents + BonusTerritory)*2,
        retract(riskCard(NextName, _)),
        retract(riskTaken(NextName))
    ;   
        Bonus is BonusContinents + BonusTerritory
    ),
    (riskCard(NextName,6) ->
        write('Player '),write(NextName),write(' terdampak SUPPLY CHAIN ISSUE!'),nl,nl,
        write('Player '),write(NextName),write(' tidak mendapatkan tentara tambahan.'),nl,nl,
        retract(riskCard(NextName, _)),
        retract(riskTaken(NextName))
    ;
        write('Player '), write(NextName), write(' mendapatkan '),
        write(Bonus),
        write('tentara tambahan.'),
        unplacedSoldier(NextName, Troops),
        NewTroops is Troops+Bonus,
        setUnplacedSoldier(NextName,NewTroops),
        nl
    ),!.

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

/* b. draft */
draft(Territory, TroopsCount) :- currentPlayer(CurrPlayer), ownedTerritory(Territory, CurrPlayer , CurrentTeritoryTroops) -> 
                (unplacedSoldier(CurrPlayer, UnplacedSoldier),
                (UnplacedSoldier > TroopsCount) -> 
                (NewNbTroops is TroopsCount + CurrentTeritoryTroops, setOwnedTerritory(Teritory, CurrPlayer, NewNbTroops ), 
                 NewUnplacedTroops is UnplacedSoldier - TroopsCount, setUnplacedSoldier(CurrPlayer, NewUnplacedTroops),
                 format('Player ~w meletakkan ~w tentara tambahan di ~w.', [CurrPlayer, TroopsCount, Teritory]), nl, nl, 
                 format('Tentara total di ~w: ~w', [Teritory, NewNbTroops]), nl,
                 format('Jumlah Pasukan Tambahan Player ~w: ~w', [CurrPlayer, NewUnplacedTroops]),nl
                ) 
                ; (write('Jumlah tentara tambahan Anda kurang.')) ) 
                ; (write('Teritory ini bukan milik Anda.')).
                                


/* d. attack */
