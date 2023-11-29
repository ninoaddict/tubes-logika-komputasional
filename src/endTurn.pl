/* a. endTurn */
endTurn:-
    isPlayTheGame(_),
    currentPlayer(Name),
    write('Player '), write(Name), write(' mengakhiri giliran.'),
    nl,nl,
    retract(queueName(Name)),
    assertz(queueName(Name)),
    currentPlayer(NextName),
    riskEndBeforeTurn(LL),
    riskCard(NextName, X),
    assertz(isAttackPossible(NextName)),
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
