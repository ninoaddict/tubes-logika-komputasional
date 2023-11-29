/* Write semua tetangga yang sudah di-pass dari list */
writeNeighbours([]) :- fail.
writeNeighbours([H|[]]) :-
    territoryName(H, SlangName), format('~w ', [SlangName]).
writeNeighbours([H|T]) :- 
    territoryName(H, SlangName), format('~w, ', [SlangName]), writeNeighbours(T).

checkLocationDetail(Teritory) :- 
            isInit(true),
            format('Kode            : ~w',[Teritory]), nl,
            territoryName(Teritory, Name),
            format('Nama            : ~w',[Name] ),nl,
            (ownedTerritory(Teritory, Owner, NbTroops) ->
                format('Pemilik         : ~w',[Owner]), nl,
                format('Total Tentara   : ~w',[NbTroops]), nl
            ;   write('Pemilik         : Tidak ada'),nl,
                write('Total Tentara   : 0'),nl
            ),
            adjacentList(Teritory, NeighbourList), 
            write('Tetangga        : '), writeNeighbours(NeighbourList), !.



