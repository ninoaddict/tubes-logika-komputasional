/* 
Boolean to check if a player already attacked 
Usage: isAttackPossible(PlayerName)
*/
:- dynamic(isAttackPossible/1).
getElementNeighbouringArea([], _, _, _) :- fail.
getElementNeighbouringArea([H|T], Owner, Idx, Elmt) :- 
    ((Idx =:= 1) -> 
    (
        ((ownedTerritory(H, Owner, _)) -> 
        (
            getElementNeighbouringArea(T, Owner, Idx, Elmt)
        );
        (
            Elmt = H
        ))
    );
    (
        ((ownedTerritory(H, Owner, _)) -> 
        (
            getElementNeighbouringArea(T, Owner, Idx, Elmt)
        );
        (
            Idx1 is Idx - 1,
            getElementNeighbouringArea(T, Owner, Idx1, Elmt)
        )) 
    )),!.

printNeighbouringArea([], _, _).
printNeighbouringArea([H|T], X, Owner) :-
    (ownedTerritory(H, Owner, _) -> 
    (
        printNeighbouringArea(T, X, Owner)
    );
    (
        format('~w. ~w', [X, H]), nl,
        _X is X + 1,
        printNeighbouringArea(T, _X, Owner)
    )),!.

neighbouringAreaLength([], _, X) :- X is 0, !.
neighbouringAreaLength([H|T], Owner, X) :- 
    (ownedTerritory(H, Owner, _) -> (
        neighbouringAreaLength(T, Owner, X)
    );
    (
        neighbouringAreaLength(T, Owner, X1),
        X is X1 + 1
    )),!.

readSelectedArea(Area, Owner, TroopsNumber) :- 
    write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '),
    read(SelectedArea), nl,
    ((ownedTerritory(SelectedArea, Owner, TN)) -> (
        Area = SelectedArea,
        TroopsNumber = TN,!
    );
    (
        write('Daerah tidak valid. Silahkan input kembali.\n\n'),
        readSelectedArea(Area, Owner, TroopsNumber)
    )),!.

readNumberOfTroops(TroopsNumber, SolNum) :- 
    write('Masukkan banyak tentara yang akan bertempur: '),
    read(SoldierToAttack), nl,
    ((SoldierToAttack =< TroopsNumber, SoldierToAttack > 0) -> (
        SolNum = SoldierToAttack,!
    );
    (
        write('Banyak tentara tidak valid. Silahkan input kembali.\n\n'),
        readNumberOfTroops(TroopsNumber, SolNum)
    )),!.

readAttackedArea(Len, NeighbouringArea, Owner, AttackedArea) :- 
    write('Pilih: '),
    read(Pipi), nl,
    ((Pipi =< Len, Pipi > 0) -> (
        getElementNeighbouringArea(NeighbouringArea, Owner, Pipi, Area),
        ownedTerritory(Area, AttackedOwner, _),
        getRiskCard(AttackedOwner, DefenderRisk),
        ((DefenderRisk =:= 1) -> 
        (
            write('Tidak bisa menyerang!\nWilayah ini dalam pengaruh CEASEFIRE ORDER.\n\n'),
            readAttackedArea(Len, NeighbouringArea, Owner, AttackedArea)
        );
        (
            AttackedArea is Area
        ))
    );
    (
        write('Input tidak valid. Silahkan input kembali.\n\n'),
        readAttackedArea(Len, NeighbouringArea, Owner, AttackedArea)
    )),!.

readStayingTroops(Len, Area, Choice) :- 
    format('Silahkan tentukan banyaknya tentara yang menetap di wilayah ~w: ', [Area]),
    read(Pipi), nl,
    ((Pipi =< Len, Pipi > 0) -> (
        Choice is Pipi,!
    );
    (
        write('Input tidak valid. Silahkan input kembali.\n\n'),
        readStayingTroops(Len, Area, Choice)
    )),!.


rollAttackDice(Index, N, _, 0):- Index =:= N,!.
rollAttackDice(Index, N, WildCard, Sum) :- 
    ((WildCard =:= 2) -> 
    (
        X is 6,
        Idx is Index + 1,
        format('Dadu ~w: ~w', [Idx, X]), nl, 
        rollAttackDice(Idx, N, Sum1),
        Sum is Sum1 + X, !
    );
    (WildCard =:= 5) ->
    (
        X is 1,
        Idx is Index + 1,
        format('Dadu ~w: ~w', [Idx, X]), nl, 
        rollAttackDice(Idx, N, Sum1),
        Sum is Sum1 + X, !
    );
    (
        rollDice(X),
        Idx is Index + 1,
        format('Dadu ~w: ~w', [Idx, X]), nl, 
        rollAttackDice(Idx, N, Sum1),
        Sum is Sum1 + X, !
    )),!.
    

/* Rule to attack */
attack :- 
    isPlayTheGame,
    currentPlayer(CurrName),
    (isAttackPossible(CurrName) -> (
        write('\nSekarang giliran Player '), write(CurrName), write(' menyerang.\n\n'),
        displayMap, nl,
        readSelectedArea(SelectedArea, CurrName, TroopsNumber),
        adjacentList(SelectedArea, NeighbouringArea),
        format('Player ~w ingin memulai penyerangan dari daerah ~w.', [CurrName, SelectedArea]),nl,
        format('Dalam daerah ~w, Anda memiliki ~w tentara.', [SelectedArea, TroopsNumber]), nl, nl,
        ((TroopsNumber > 1) -> 
        (
            readNumberOfTroops(TroopsNumber, SoldierToAttack),
            displayMap, nl, nl,
            neighbouringAreaLength(NeighbouringArea, CurrName, Len),
            ((Len =:= 0)->
            (
                write('Maaf anda tidak bisa menyerang daerah mana pun karena tidak ada daerah yang tersedia\n\n')
            );
            (
                write('Pilihlah daerah yang ingin Anda serang.\n'),
                printNeighbouringArea(NeighbouringArea, 1, CurrName),
                nl, 
                readAttackedArea(Len, NeighbouringArea, CurrName, AttackedArea),
                ownedTerritory(AttackedArea, AttackedOwner, AttackedTroopsNumber),
                getRiskCard(CurrName, AttackerRisk),
                getRiskCard(AttackedOwner, DefenderRisk),
                ((AttackerRisk =:= 2) -> format('Tentara ~w dalam pengaruh SUPER SOLDIER SERUM.\n\n', [CurrName])),
                ((DefenderRisk =:= 2) -> format('Tentara ~w dalam pengaruh SUPER SOLDIER SERUM.\n\n', [AttackedOwner])),
                ((AttackerRisk =:= 5) -> format('Tentara ~w dalam pengaruh DISEASE OUTBREAK.\n\n', [CurrName])),
                ((DefenderRisk =:= 5) -> format('Tentara ~w dalam pengaruh DISEASE OUTBREAK.\n\n', [AttackedOwner])),
                write('Perang telah dimulai.\n'),
                format('Player ~w\n', [CurrName]),
                rollAttackDice(0, SoldierToAttack, AttackerRisk, Sum1),
                format('Total: ~w\n\n', [Sum1]),
                format('Player ~w\n', [AttackedOwner]),
                rollAttackDice(0, AttackedTroopsNumber, DefenderRisk, Sum2),
                format('Total: ~w\n\n', [Sum2]),
                ((Sum1 > Sum2) -> (
                    format('Player ~w menang! Wilayah ~w sekarang dikuasai Oleh Player ~w.\n\n', [CurrName, AttackedArea, CurrName]),
                    readStayingTroops(SoldierToAttack, AttackedArea, ResSol),
                    NewX is TroopsNumber - ResSol,
                    NewY is ResSol,
                    setOwnedTerritory(SelectedArea, CurrName, NewX),
                    setOwnedTerritory(AttackedArea, CurrName, NewY),
                    format('Tentara di wilayah ~w: ~w\n', [SelectedArea, NewX]),
                    format('Tentara di wilayah ~w: ~w\n', [AttackedArea, NewY]),
                    checkLose(AttackedOwner),
                    checkWin(CurrName)
                );
                (
                    format('Player ~w menang! Sayang sekali, penyerangan anda gagal!\n :(\n\n', [AttackedOwner]),
                    _pipi is (TroopsNumber - SoldierToAttack),
                    setOwnedTerritory(SelectedArea, CurrName, _pipi),
                    format('Tentara di wilayah ~w: ~w\n', [SelectedArea, _pipi]),
                    format('Tentara di wilayah ~w: ~w\n', [AttackedArea, AttackedTroopsNumber])
                ))
            ))
        );
        (write('Anda tidak bisa menyerang karena Anda memiliki tepat satu tentara\n')))
    );
    (
        write('Anda sudah pernah menyerang sebelumnya!\n\n')
    )),!.

getRiskCard(Username, UsernameRisk) :- 
    (riskCard(Username, UR) -> 
    (
        UsernameRisk is UR
    );
    (
        UsernameRisk is 0
    )),!.