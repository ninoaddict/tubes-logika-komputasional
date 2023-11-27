endTurn:-
    currentPlayer(Name),
    write('Player '), write(Name), write(' mengakhiri giliran.'),
    nl,nl,
    retract(queueName(Name)),
    assertz(queueName(Name)),
    currentPlayer(NextName),
    write('Sekarang giliran Player '), write(NextName), write('!'),
    nl,
    bonusSoldierFromContinents(NextName, BonusContinents),
    bonusSoldierFromTerritory(NextName,BonusTerritory),
    Bonus is BonusContinents + BonusTerritory,
    write('Player '), write(NextName), write(' mendapatkan '),
    write(Bonus),
    write('tentara tambahan.'),
    nl,!.

/* b. draft */
draft(Territory, TroopsCount) :- player(CurrPlayer), ownedTerritory(Territory, CurrPlayer , CurrentTeritoryTroops) -> 
                (unplacedSoldier(CurrPlayer, UnplacedSoldier),
                (UnplacedSoldier < TroopsCount) -> 
                (NewNbTroops is TroopsCount + CurrentTeritoryTroops, setOwnedTerritory(Teritory, CurrPlayer, NewNbTroops ), 
                 NewUnplacedTroops is UnplacedSoldier - TroopsCount, setUnplacedSoldier(CurrPlayer, NewUnplacedTroops),
                 format('Player ~w meletakkan ~w tentara tambahan di ~w.', [CurrPlayer, TroopsCount, Teritory]), nl, nl, 
                 format('Tentara total di ~w: ~w', [Teritory, NewNbTroops]), nl
                 format('Jumlah Pasukan Tambahan Player ~w: ~w', [CurrPlayer, NewUnplacedTroops]),nl
                ) 
                ; (write('Jumlah tentara tambahan Anda kurang.')) ) 
                ; (write('Teritory ini bukan milik Anda.')).
                                
/* c. move */  

