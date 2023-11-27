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
draft(Territory, TroopsCount) :- currentPlayer(CurrPlayer), ownedTerritory(Territory, CurrPlayer , CurrentTeritoryTroops) -> 
                (unplacedSoldier(CurrPlayer, UnplacedSoldier),
                (UnplacedSoldier > TroopsCount) -> 
                (NewNbTroops is TroopsCount + CurrentTeritoryTroops, setOwnedTerritory(Teritory, CurrPlayer, NewNbTroops ), 
                 NewUnplacedTroops is UnplacedSoldier - TroopsCount, setUnplacedSoldier(CurrPlayer, NewUnplacedTroops),
                 format('Player ~w meletakkan ~w tentara tambahan di ~w.', [CurrPlayer, TroopsCount, Teritory]), nl, nl, 
                 format('Tentara total di ~w: ~w', [Teritory, NewNbTroops]), nl
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