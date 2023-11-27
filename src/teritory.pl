checkLocationDetail(Teritory) :- 
            ownedTerritory(Teritory, Owner, NbTroops), 
            format('Kode            : ~w',[Teritory]), nl,
            territoryName(Teritory, Name),
            format('Nama            : ~w',[Name] ),nl,
            format('Pemilik         : ~w',[Owner]), nl,
            format('Total Tentara   : ~w',[NbTroops]), nl,
            adjacentList(Teritory, NeighbourList), 
            write('Tetangga        : '), writeNeighbours(NeighbourList), !.



