endTurn:-
    currentPlayer(Name),
    write('Player '), write(Name), write(' mengakhiri giliran.'),
    nl,nl,
    retract(queueName(Name)),
    assertz(queueName(Name)),
    currentPlayer(NextName),
    write('Sekarang giliran Player '), write(NextName), write('!'),
    nl,
    bonusSoldierFromContinents(NextName, ListBonus),
    bonusSoldierFromTerritory(NextName,BonusTerritory),
    sumUntil(ListBonus,5,BonusContinents),
    (riskCard(NextName,'AUXILIARY TROOPS') ->
        write('Player '),write(NextName),write(' mendapatkan AUXILIARY TROOPS!'),nl,
        Bonus is (BonusContinents + BonusTerritory)*2
    ;   
        Bonus is BonusContinents + BonusTerritory
    )
    write('Player '), write(NextName), write(' mendapatkan '),
    write(Bonus),
    write('tentara tambahan.'),
    unplacedSoldier(NextName, Troops),
    NewTroops is Troops+Bonus,
    setUnplacedSoldier(NextName,NewTroops),
    nl,!.

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
                                

/* c. move */
move(Origin, Dest, X) :- 
    currentPlayer(_currName),
    (ownedTerritory(Origin, _currName, _X) -> (
        (ownedTerritory(Dest, _currName, _Y) -> (
            nl, write(_currName), write(' memindahkan '), write(X), write(' tentara dari '), write(Origin), write(' ke '), write(Dest), write('.\n\n'),
            ((_X > X) -> (
                _newX is _X - X,
                _newY is _Y + X,
                setOwnedTerritory(Origin, _currName, _newX),
                setOwnedTerritory(Dest, _currName, _newY),
                write('Jumlah tentara di '), write(Origin), write(': '), write(_newX), write('\n'),
                write('Jumlah tentara di '), write(Dest), write(': '), write(_newY), write('\n'),!
            ));
            (write('Tentara tidak mencukupi.\npemindahan dibatalkan.\n')),!
        ));
        (nl, write(_currName), write(' tidak memiliki wilayah '), write(Dest), write('.\n'), write('pemindahan dibatalkan'), nl), !
    ));  
    (nl, write(_currName), write(' tidak memiliki wilayah '), write(Origin), write('.\n'), write('pemindahan dibatalkan'), nl), !. 

/* d. attack */
