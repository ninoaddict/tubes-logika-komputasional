:- dynamic(traversal/1).
:- dynamic(listName/1).
:- dynamic(listDice/1).
:- dynamic(isInit/1).
:- dynamic(isTerritoryPhase/1).
:- dynamic(isPlayTheGame/1).
:- dynamic(isSpreadSoldier/1).

startGame :-
    \+isInit(_),
    retractall(nbPlayer(_)),
    retractall(traversal(_)),
    retractall(listName(_)),
    retractall(isPlayTheGame(_)),
    retractall(isSpreadSoldier(_)),
    retractall(ownedTerritory(_,_,_)),
    retractall(ownedContinent(_,_)),
    retractall(unplacedSoldier(_,_)),
    repeat,
    write('\nMasukkan jumlah pemain: '),
    read(NBPlayer),
    (validNBPlayer(NBPlayer) ->
        !
    ;
        write('Mohon masukkan angka antara 2 - 4.\n'),
        fail
    ),
    assertz(nbPlayer(NBPlayer)),
    nl,
    retractall(traversal(_)),
    assertz(traversal(0)),
    retractall(listName(_)),
    assertz(listName([])),
    askPlayerNames(1, NBPlayer),
    repeat,
    retractall(listDice(_)), nl,
    assertz(listDice([])),
    InitNum is 1,
    (countPlayerDice(InitNum) ->
        listDice(ListDice),
        (isMaxValid(ListDice) ->
            !
        ; 
            write('\nAda beberapa pemain dengan gulungan dadu terbesar yang sama, pelemparan dadu diulang.\n'),
            fail
        )
    ; 
        true
    ),
    handleOrder, nl,
    write('Urutan pemain:'), Order is 1,displayOrder(Order),
    currentPlayer(CurP),
    format('~w dapat memulai terlebih dahulu.\n', [CurP]), nl,
    soldierPerPlayer(Count),
    handleUnplacedSoldier(1),
    format('Setiap pemain mendapatkan ~d tentara.\n', [Count]),
    format('\nGiliran ~w untuk memilih wilayahnya.\n', [CurP]),
    assertz(isInit(true)),
    assertz(isTerritoryPhase(true)),
    retractall(listDice(_)), retractall(traversal(_)),!.

takeLocation(Terr) :-
    isTerritoryPhase(_),
    territoryContinent(_, Terr),
    currentPlayer(Name),
    (
        \+(ownedTerritory(Terr, _, _)) ->
            format('\n~w mengambil wilayah ~w.\n', [Name, Terr]),
            assertz(ownedTerritory(Terr, Name, 1)),
            unplacedSoldier(Name, X),
            XX is X -1,
            setUnplacedSoldier(Name, XX),
            retract(player(Nm)),
            assertz(player(Nm))
    ;
        ownedTerritory(Terr,_,_),write('\nWilayah sudah dikuasai. Tidak bisa mengambil.\n')
    ),
    currentPlayer(Cpl),
    (
        spreadSoldierPhase ->
            retractall(isTerritoryPhase(_)), 
            assertz(isSpreadSoldier(true)),
            write('\nSeluruh wilayah telah diambil pemain.\n'),
            write('Memulai pembagian sisa tentara.\n'),
            format('Giliran ~w untuk meletakkan tentaranya.\n', [Cpl])
            ;
            format('\nGiliran ~w untuk memilih wilayahnya.\n', [Cpl])
    ),
    !.

placeTroops(Terr, Ntroop):-
    isSpreadSoldier(_),
    Ntroop > 0,
    currentPlayer(Cpl),
    (ownedTerritory(Terr,Cpl,_) ->
        ((unplacedSoldier(Cpl, TroopsLeft),
        (TroopsLeft < Ntroop,
        write('\nPasukan tidak mencukupi.\n'),
        format('Jumlah Pasukan Player ~w: ~d\n', [Cpl,TroopsLeft]));
        (unplacedSoldier(Cpl,TroopsL),TroopsL >= Ntroop,
        retract(unplacedSoldier(Cpl, TL)),
        TL1 is TL - Ntroop,
        assertz(unplacedSoldier(Cpl, TL1)),
        retract(ownedTerritory(Terr, Cpl, Troops)),
        TroopsNow is Troops+Ntroop,
        assertz(ownedTerritory(Terr, Cpl, TroopsNow)),
        format('\n~w meletakkan ~d tentara di wilayah ~w.\n',[Cpl, Ntroop, Terr]),
        (TL1 > 0 -> 
            format('Terdapat ~d tentara tersisa.\n', [TL1]);
            format('Seluruh tentara ~w sudah diletakkan.\n', [Cpl]),
            retract(player(Name)),
            assertz(player(Name))
        ),
        (playTheGame ->
            write('\nSeluruh pemain telah meletakkan sisa tentara.\n'),
            write('Memulai permainan.\n'),
            retractall(isSpreadSoldier(_)),
            assertz(isPlayTheGame(true)),
            intiateFirstTurn
            ;
            true, !
        ))),
            (\+playTheGame ->
                currentPlayer(CurrPl),
                format('\nGiliran ~w untuk meletakkan tentaranya.\n', [CurrPl]);
                true, !
            )
        )
        ;
        write('\nWilayah tersebut dimiliki pemain lain.\n'),
        write('Silahkan pilih wilayah lain.\n'),
        format('\nGiliran ~w untuk meletakkan tentaranya.\n', [Cpl])
    ),
    !.

placeAutomatic:-
    isSpreadSoldier(_),
    handleListTerritory(ListT),
    nl, currentPlayer(Cpl),
    unplacedSoldier(Cpl, Num),
    listLength(ListT, Len),
    handlePlacement(Num, ListT, Len),
    setUnplacedSoldier(Cpl, 0),
    format('Seluruh tentara ~w sudah diletakkan.', [Cpl]),nl,
    retract(player(Name)),
    assertz(player(Name)),
    (playTheGame,
        nl,
        write('Seluruh pemain telah meletakkan sisa tentara.\n'),
        write('Memulai permainan.\n'),
        retractall(isSpreadSoldier(_)),
        assertz(isPlayTheGame(true)),
        intiateFirstTurn
        ;
    \+playTheGame,
        currentPlayer(NewPlayer),
        format('\nGiliran ~w untuk meletakkan tentaranya.\n', [NewPlayer])
        ),
    !.

intiateFirstTurn:-
    currentPlayer(Name),
    format('\nSekarang giliran Player ~w!\n', [Name]),
    bonusSoldierFromContinents(Name, ListBonus),
    bonusSoldierFromTerritory(Name, BonusTerritory),
    sumUntil(ListBonus,5,BonusContinents),
    Bonus is BonusContinents + BonusTerritory,
    format('Player ~w mendapatkan ~d tentara tambahan.\n', [Name, Bonus]),
    unplacedSoldier(Name, Troops),
    NewTroops is Troops+Bonus,
    assertz(isAttackPossible(Name)),
    setUnplacedSoldier(Name, NewTroops),!.

handleListTerritory(Res):-
    currentPlayer(Cpl),
    handleListTerritoryForPlayer(Cpl, Hasil), Res = Hasil,!.

handleListTerritoryForPlayer(Name, Res):-
    findall(Territory, ownedTerritory(Territory, Name, _), PlayerTerritories),
    Res = PlayerTerritories, !.

handlePlacement(N, ListTer, Len) :- 
    N > 0, Len > 0,
    currentPlayer(Cpl),
    (Len =:= 1 ->
        getName(ListTer, 1, X),
        retract(ownedTerritory(X, Cpl, Troops)),
        assertz(ownedTerritory(X, Cpl, N + Troops)),
        format('~w meletakkan ~d tentara di wilayah ~w.\n', [Cpl, N, X])
    ;
        Len1 is Len + 1,
        random(1, Len1, Rndm),
        getName(ListTer, Rndm, Terr),
        deleteAt(ListTer, Rndm, NewList),
        currentPlayer(Cpl),
        retract(ownedTerritory(Terr, Cpl, Troops)),
        N1 is N + 1,
        random(1, N1, RTroops),
        FT is Troops + RTroops,
        assertz(ownedTerritory(Terr, Cpl, FT)),
        format('~w meletakkan ~d tentara di wilayah ~w.\n', [Cpl, RTroops, Terr]),
        listLength(NewList, NL),
        N2 is N - RTroops,
        handlePlacement(N2, NewList, NL)
    ;
    true, !
    ), !.

validNBPlayer(N):- N > 1, N < 5, !.

askPlayerNames(N, Nb) :- 
    (N =< Nb -> 
        repeat,
            format('Masukkan nama pemain ~d: ', [N]),
            read(PlayerName),
            (isInList(PlayerName) -> (
                format('Nama pemain ~w sudah diambil.\n', [PlayerName]),
                fail
            ) ; (
                addPlayerName(PlayerName),
                N1 is N + 1,
                askPlayerNames(N1, Nb)
            )),
        ! ; true).

endAskPlayerName(N) :- nbPlayer(Nb), N =:= Nb, !.

addPlayerName(X) :- 
    retract(listName(L)),
    append(L, [X], Res),
    assertz(listName(Res)).
    
isInList(X) :- 
    listName(L),
    member(X, L).

countPlayerDice(N):-
    nbPlayer(Nplayer), 
    (N =< Nplayer, 
    roll2Dices(DiceNum),
    listName(LisNem), 
    getName(LisNem, N, CurName),
    format('~w melempar dadu dan mendapatkan ~d.\n', [CurName, DiceNum]),
    retract(listDice(DiceList)),
    addEnd(DiceList, DiceNum, NewDice),
    assertz(listDice(NewDice)),
    N1 is N + 1,
    countPlayerDice(N1), !
    ; true
    ),
    !.

handleOrder:-
    retractall(player(_)), retractall(turnPlayer(_,_)),
    listDice(LD),
    max(LD, Max),
    getIndex(LD, Max, Index),
    listName(LN),
    setPlayerOrder(Index, LN, 1),!.

setPlayerOrder(1, [], _) :-!.
setPlayerOrder(1, [A|B], Num):-
    assertz(player(A)), assertz(turnPlayer(A,Num)),
    Num1 is Num + 1, setPlayerOrder(1, B, Num1), !.
setPlayerOrder(Idx, [A|B], Num):-
    Idx1 is Idx -1, addEnd(B,A,Res),setPlayerOrder(Idx1,Res,Num), !.

displayOrder(N):-
    nbPlayer(Nplayer),
    (N =< Nplayer,
    retract(player(Name)),
    (N =\= Nplayer -> (
        format(' ~w -', [Name])
    );(
        format(' ~w\n', [Name])
    )),
    assertz(player(Name)),
    N1 is N+1, displayOrder(N1); true),
    !. 

handleUnplacedSoldier(N) :-
    nbPlayer(Nplayer),
    (N =< Nplayer,
    (
        Nplayer =:= 2,
        retract(player(Name)),
        assertz(unplacedSoldier(Name, 24)),
        assertz(player(Name));
        Nplayer =:= 3,
        retract(player(Name)),
        assertz(unplacedSoldier(Name, 16)),
        assertz(player(Name));
        Nplayer =:= 4,
        retract(player(Name)),
        assertz(unplacedSoldier(Name, 12)),
        assertz(player(Name))
    ), N1 is N+1,handleUnplacedSoldier(N1);
    true
    ), !.

soldierPerPlayer(Count):-
    nbPlayer(Nplayer),
    (Nplayer =:= 2, Count is 24;
    Nplayer =:= 3, Count is 16;
    Nplayer =:= 4, Count is 12),
    !.

spreadSoldierPhase:-
    ownedTerritory(as1,_,_),
    ownedTerritory(as2,_,_),
    ownedTerritory(as3,_,_),
    ownedTerritory(as4,_,_),
    ownedTerritory(as5,_,_),
    ownedTerritory(as6,_,_),
    ownedTerritory(as7,_,_),
    ownedTerritory(eu1,_,_),
    ownedTerritory(eu2,_,_),
    ownedTerritory(eu3,_,_),
    ownedTerritory(eu4,_,_),
    ownedTerritory(eu5,_,_),
    ownedTerritory(na1,_,_),
    ownedTerritory(na2,_,_),
    ownedTerritory(na3,_,_),
    ownedTerritory(na4,_,_),
    ownedTerritory(na5,_,_),
    ownedTerritory(sa1,_,_),
    ownedTerritory(sa2,_,_),
    ownedTerritory(af1,_,_),
    ownedTerritory(af2,_,_),
    ownedTerritory(af3,_,_),
    ownedTerritory(au1,_,_),
    ownedTerritory(au2,_,_),!.

playTheGame:-
    listName(LN),
    handlePlayTheGame(LN),!.

handlePlayTheGame([]):-!.
handlePlayTheGame([A|B]):-
    unplacedSoldier(A,NTroops),
    NTroops =:= 0,
    handlePlayTheGame(B),!.
    