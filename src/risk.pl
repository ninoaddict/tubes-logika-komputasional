:- dynamic(riskCard/2). %playerName, riskCardType
:- dynamic(riskTaken/1).

riskCardList(['CEASEFIRE ORDER', 'SUPER SOLDIER SERUM', 'AUXILIARY TROOPS', 'REBELLION', 'DISEASE OUTBREAK', 'SUPPLY CHAIN ISSUE']).
riskCardContent(['Hingga giliran berikutnya, wilayah pemain tidak dapat diserang oleh lawan.', 'Hingga giliran berikutnya, \nsemua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 6.', 'Pada giliran berikutnya,\nTentara tambahan yang didapatkan pemain akan bernilai 2 kali lipat.', 'Salah satu wilayah acak pemain akan berpindah kekuasaan menjadi milik lawan.', 'Hingga giliran berikutnya,\nsemua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 1.','Pada giliran berikutnya, pemain tidak mendapatkan tentara tambahan.']).

riskEndBeforeTurn([1,2,5]).
riskEndAfterTurn([3,6]).

riskDraw(X):-
    random(1,7,R), X is R, !.

risk:-
    isPlayTheGame(_),
    currentPlayer(Cpl),
    \+riskCard(Cpl, _), \+riskTaken(Cpl),
    riskDraw(R),
    riskCardList(L),
    riskCardContent(LL),
    getName(L, R, TypeCard),
    getName(LL, R, Content),
    format('\nPlayer ~w mendapatkan risk card ~w.\n', [Cpl,TypeCard]),
    format('~w\n', [Content]),
    (R =:= 4 ->
        handleRebellion,
        
        ;
        assertz(riskCard(Cpl, R))
    ), assertz(riskTaken(Cpl)),!.


handleRebellion:-
    currentPlayer(Name),
    listName(LN),
    isIn(LN,Name, Idx),
    deleteAt(LN, Idx, NewLN),
    listLength(NewLN, Length),
    L1 is Length+1,
    random(1,L1, Index),
    getName(NewLN,Index,Target),
    findall(Territory, ownedTerritory(Territory, Name, _), ListTerritory),
    listLength(ListTerritory, LTerr),
    LL is LTerr + 1,
    random(1,LL, RLT),
    getName(ListTerritory, RLT, Rebel),
    retract(ownedTerritory(Rebel, Name, NTroop)),
    assertz(ownedTerritory(Rebel, Target, NTroop)),
    format('\nWilayah ~w sekarang dikuasai oleh Player ~w.\n', [Rebel, Target]),
    !.
