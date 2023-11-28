printNeighbouringArea([], _).
printNeighbouringArea([H|T], X) :- 
    format('~w. ~w', [X, H]), nl,
    _X is X + 1,
    printNeighbouringArea(T, _X).

readSelectedArea(Area, Owner, TroopsNumber) :- 
    write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '),
    read(SelectedArea), nl,
    ((ownedTerritory(SelectedArea, Owner, TN)) -> (
        Area = SelectedArea,
        TroopsNumber = TN,!
    ));
    (
        write('Daerah tidak valid. Silahkan input kembali.\n\n'),
        readSelectedArea(Area, Owner, TroopsNumber)
    ),!.

readNumberOfTroops(TroopsNumber, SolNum) :- 
    write('Masukkan banyak tentara yang akan bertempur: '),
    read(SoldierToAttack), nl,
    ((SoldierToAttack =< TroopsNumber, SoldierToAttack > 0) -> (
        SolNum = SoldierToAttack,!
    ));
    (
        write('Banyak tentara tidak valid. Silahkan input kembali.\n\n'),
        readNumberOfTroops(TroopsNumber, SolNum)
    ),!.

readAttackedArea(Len, Choice) :- 
    write('Pilih: '),
    read(Pipi), nl,
    ((Pipi =< Len, Pipi > 0) -> (
        Choice = Pipi,!
    ));
    (
        write('Input tidak valid. Silahkan input kembali.\n\n'),
        readAttackedArea(Len, Choice)
    ).

readStayingTroops(Len, Area, Choice) :- 
    format('Silahkan tentukan banyaknya tentara yang menetap di wilayah ~w: ', [Area]),
    read(Pipi), nl,
    ((Pipi =< Len, Pipi > 0) -> (
        Choice is Pipi,!
    ));
    (
        write('Input tidak valid. Silahkan input kembali.\n\n'),
        readStayingTroops(Len, Area, Choice)
    ).


rollAttackDice(Index, N, 0):- Index =:= N,!.
rollAttackDice(Index, N, Sum) :- 
    rollDice(X),
    Idx is Index + 1,
    format('Dadu ~w: ~w', [Idx, X]), nl, 
    rollAttackDice(Idx, N, Sum1),
    Sum is Sum1 + X, !.

attack :- 
    currentPlayer(CurrName),
    write('\nSekarang giliran Player '), write(CurrName), write(' menyerang.\n\n'),
    displayMap, nl,
    readSelectedArea(SelectedArea, CurrName, TroopsNumber),
    adjacentList(SelectedArea, NeighbouringArea),
    format('Player ~w ingin memulai penyerangan dari daerah ~w.', [CurrName, SelectedArea]),nl,
    format('Dalam daerah ~w, Anda memiliki ~w tentara.', [SelectedArea, TroopsNumber]), nl, nl,
    ((TroopsNumber > 1) -> (
        readNumberOfTroops(TroopsNumber, SoldierToAttack),
        displayMap, nl, nl,
        write('Pilihlah daerah yang ingin Anda serang.\n'),
        printNeighbouringArea(NeighbouringArea, 1),
        nl,
        listLength(NeighbouringArea, Len),
        readAttackedArea(Len, Choice),
        getElementString(NeighbouringArea, Choice, AttackedArea),
        write('Perang telah dimulai.\n'),
        ownedTerritory(AttackedArea, AttackedOwner, AttackedTroopsNumber),
        format('Player ~w\n', [CurrName]),
        rollAttackDice(0, SoldierToAttack, Sum1),
        format('Total: ~w\n\n', [Sum1]),
        format('Player ~w\n', [AttackedOwner]),
        rollAttackDice(0, AttackedTroopsNumber, Sum2),
        format('Total: ~w\n\n', [Sum2]),
        ((Sum1 > Sum2) (
            format('Player ~w menang! Wilayah ~w sekarang dikuasai Oleh Player ~w.\n\n', [CurrName, AttackedArea, CurrName]),
            readStayingTroops(SoldierToAttack, AttackedArea, ResSol),
            NewX is TroopsNumber - ResSol,
            NewY is ResSol,
            setOwnedTerritory(SelectedArea, CurrName, NewX),
            setOwnedTerritory(AttackedArea, CurrName, NewY),
            format('Tentara di wilayah ~w: ~w\n', [SelectedArea, NewX]),
            format('Tentara di wilayah ~w: ~w\n', [AttackedArea, NewY])
        );
        (
            format('Player ~w menang! Sayang sekali, penyerangan anda gagal!\n :(\n\n', [AttackedOwner]),
            _pipi is (TroopsNumber - SoldierToAttack),
            setOwnedTerritory(SelectedArea, CurrName, _pipi),
            format('Tentara di wilayah ~w: ~w\n', [SelectedArea, _pipi]),
            format('Tentara di wilayah ~w: ~w\n', [AttackedArea, AttackedTroopsNumber])
        ))
    );
    (write('Anda tidak bisa menyerang karena Anda memiliki tepat satu tentara\n'))),!.