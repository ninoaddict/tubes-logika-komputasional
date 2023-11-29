extraTroops(Add):-
    isPlayTheGame(_),
    currentPlayer(Name),
    unplacedSoldier(Name, X),
    NewX is X + Add,
    setUnplacedSoldier(Name, NewX),
    write('\nCheat success:\n'),
    format('~d tentara berhasil diseludupkan.\n',[Add]),
    format('Tentara ~w saat ini: ~d\n', [Name,NewX]), !.

acquisitionTerritory(Terr):-
    isPlayTheGame(_),
    territoryContinent(_, Terr),
    currentPlayer(Name),
    (ownedTerritory(Terr, Name,_) -> (
        format('\nWilayah ~w memang milik ~w.\n', [Terr, Name])
    );
    (   
        retract(ownedTerritory(Terr,Enemy,Num)),
        assertz(ownedTerritory(Terr, Name, Num)),
        write('\nCheat success:\n'),
        format('Wilayah ~w telah menjadi milik ~w.\n', [Terr, Name]),
        (checkLose(Enemy) -> (
            currentPlayer(Neme),
            (checkWin(Neme) -> true; true)
        );
        true)
    )),!.

pickRiskCard(X):-
    isPlayTheGame(_),
    currentPlayer(Name),
    (riskCard(Name, _) -> retract(riskCard(Name, _)) ; true),
    (riskTaken(Name) -> true; assertz(riskTaken(Name))),
    riskCardList(L),
    riskCardContent(LL),
    getName(L, X, TypeCard),
    getName(LL, X, Content),
    write('\nCheat success:\n'),
    format('\nPlayer ~w mendapatkan risk card ~w.\n', [Name,TypeCard]),
    format('~w\n', [Content]),
    (X =:= 4 ->
        handleRebellion, currentPlayer(CurrP),
        (checkLose(CurrP) -> (
            currentPlayer(Winner), 
            (checkWin(Winner) -> (
                true 
            ) ; (
                true))
        ) ; (true))
        ;
        assertz(riskCard(Name, X))
    ),!.
