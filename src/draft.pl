/* b. draft */
draft(Territory, TroopsCount) :- isPlayTheGame(_), territoryContinent(_Continent, Territory), TroopsCount > 0, !,
                 (currentPlayer(CurrPlayer),  ownedTerritory(Territory, CurrPlayer , CurrentTerritoryTroops) -> 
                    (unplacedSoldier(CurrPlayer, UnplacedSoldier),
                    (UnplacedSoldier >= TroopsCount) -> 
                        (NewNbTroops is TroopsCount + CurrentTerritoryTroops,
                        NewUnplacedTroops is UnplacedSoldier - TroopsCount, setUnplacedSoldier(CurrPlayer, NewUnplacedTroops),
                        setOwnedTerritory(Territory, CurrPlayer, NewNbTroops ), nl,
                        format('Player ~w meletakkan ~w tentara tambahan di ~w.', [CurrPlayer, TroopsCount, Territory]), nl, nl, 
                        format('Tentara total di ~w: ~w', [Territory, NewNbTroops]), nl,
                        format('Jumlah Pasukan Tambahan Player ~w: ~w', [CurrPlayer, NewUnplacedTroops]),nl
                        ) 
                    ; (nl, write('Jumlah tentara tambahan Anda kurang.'))) 
                ; (nl, write('Territory ini bukan milik Anda.'))).