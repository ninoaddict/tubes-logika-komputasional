/* c. Move */
move(Origin, Dest, X) :- 
    isPlayTheGame(_),
    currentPlayer(_currName),
    (ownedTerritory(Origin, _currName, _X) -> (
        (ownedTerritory(Dest, _currName, _Y) -> (
            nl, write(_currName), write(' memindahkan '), write(X), write(' tentara dari '), write(Origin), write(' ke '), write(Dest), write('.\n\n'),
            ((_X > X) -> (
                _newX is _X - X,
                _newY is _Y + X,
                setOwnedTerritory(Origin, _currName, _newX),
                setOwnedTerritory(Dest, _currName, _newY),
                write('Jumlah tentara di '), write(Origin), write(': '), write(_newX), write('\n'),
                write('Jumlah tentara di '), write(Dest), write(': '), write(_newY), write('\n'),!
            );
            (write('Tentara tidak mencukupi.\npemindahan dibatalkan.\n'))),!
        );
        (nl, write(_currName), write(' tidak memiliki wilayah '), write(Dest), write('.\n'), write('pemindahan dibatalkan'), nl)), !
    );  
    (nl, write(_currName), write(' tidak memiliki wilayah '), write(Origin), write('.\n'), write('pemindahan dibatalkan'), nl)), !. 