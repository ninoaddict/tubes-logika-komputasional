move(Origin, Dest, X) :- 
    frontName(_currName),
    (ownedTerritory(_currName,Origin,_) -> (
        
    ))  
    ;(write(_currName), write(" tidak memiliki wilayah "), write(Origin)), write('.\n'), write('pemindahan dibatalkan'), nl. 