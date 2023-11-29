/* Write semua tetangga yang sudah di-pass dari list */
writeNeighbours([]) :- fail.
writeNeighbours([H|[]]) :-
    territoryName(H, SlangName), format('~w ', [SlangName]).
writeNeighbours([H|T]) :- 
    territoryName(H, SlangName), format('~w, ', [SlangName]), writeNeighbours(T).

/* Check detail dari suatu lokasi */
checkLocationDetail(Territory) :- 
            isPlayTheGame(_),
            ownedTerritory(Territory, Owner, NbTroops), 
            format('Kode            : ~w',[Territory]), nl,
            territoryName(Territory, Name),
            format('Nama            : ~w',[Name] ),nl,
            format('Pemilik         : ~w',[Owner]), nl,
            format('Total Tentara   : ~w',[NbTroops]), nl,
            adjacentList(Territory, NeighbourList), 
            write('Tetangga        : '), writeNeighbours(NeighbourList), !.



