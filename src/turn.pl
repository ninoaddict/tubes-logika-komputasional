endTurn:-
    currentPlayer(Name),
    write('Player '), write(Name), write(' mengakhiri giliran.'),
    nl,nl,
    retract(queueName(Name)),
    assertz(queueName(Name)),
    currentPlayer(NextName),
    write('Sekarang giliran Player '), write(NextName), write('!'),
    nl,
    write('Player '), write(NextName), write(' mendapatkan '),
    write('( )'),
    write('tentara tambahan.'),
    nl,!.

/* count How many Owner have territories */
countOwnedTerritories(Owner, Count):-
    findall(Territories, ownedTerritory(Territories, Owner, _), OwnedTerritories),
    length(OwnedTerritories,Count).

/* list all continentt that Owner own in Continents*/
AllOwnedContinent(Owner, Continents):-
    findall(Continent, ownedContinent(Continent, Owner), Continents),

/* bonus soldier from owned Continents priviledge */
bonusSoldierFromContinents(Owner,Bonus):-
    Bonus is 0,
    AllOwnedContinent(Owner, Continents),
    (member(asia,Continents) ->
        Bonus is Bonus + 5
    ),
    (member(europe, Continents) ->
        Bonus is Bonus + 3
    ),
    (member(north_america, Continents) ->
        Bonus is Bonus + 3
    ),
    (member(south_america, Continents) ->
        Bonus is Bonus + 2
    ),
    (member(africa, Continents) ->
        Bonus is Bonus + 2
    ),
    (member(australia, Continents) ->
        Bonus is Bonus + 1
    ),
    Bonus is Bonus, !.

/* b. draft */
draft(Territory, TroopsCount) :- player(X), ownedTerritory(Territory, X , CurrentTeritoryTroops) -> 
                (unplacedSoldier(X, UnplacedSoldier),
                (UnplacedSoldier < TroopsCount) -> setOwnedTerritory(Teritory, )
                (NewNbTroops is TroopsCount + CurrentTeritoryTroops, ,
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