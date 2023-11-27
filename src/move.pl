:- dynamic(ownedTerritory/3). /* teritoryCode, ownerName, troopsCount */
listLength([], X) :- X is 0, !.
listLength([H|T], X) :- listLength(T, X1), X is X1 + 1, !.

getElement([], _, _) :- fail.
getElement([A|B], Idx, ELmt) :- 
    (Idx =:= 1, ELmt = A, !);
    (Idx =\= 1, Idx1 is Idx -1, getElement(B, Idx1, ELmt)).

rollDice(X):-
    random(1,7,Result),
    X = Result.

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
    ((Pipi =< Len, Pipi > 0) -> [
        Choice = Pipi,!
    ]);
    (
        write('Input tidak valid. Silahkan input kembali.\n\n'),
        readStayingTroops(Len, Area, Choice)
    ).


rollAttackDice(N, N, 0).
rollAttackDice(Index, N, Sum) :- 
    rollDice(X),
    Idx is Index + 1,
    format('Dadu ~w: ~w', [Idx, X]), nl, 
    rollAttackDice(Idx, N, Sum1),
    Sum is Sum1 + X, !.

currentPlayer(berto).

integerToString(X, Y) :- X < 10, number_codes(X, Codes), atom_codes(String, Codes), atom_concat('00', String, Y), !.
integerToString(X, Y) :- X < 100, number_codes(X, Codes), atom_codes(String, Codes), atom_concat('0', String, Y), !.
integerToString(X, Y) :- Y is X,!. 

displayMap :- 
    nl,
    write('##########################################################################################################\n'),
    write('#           North America           #        Europe           #                 Asia                     #\n'),
    write('#                                   #                         #                                          #\n'),
    write('#       [NA1('), ownedTerritory(na1, _, _NA1), integerToString(_NA1, _RNA1), write(_RNA1), write(')]-[NA2('), ownedTerritory(na2, _, _NA2), integerToString(_NA2, _RNA2), write(_RNA2), write(')]       #                         #                                          #\n'),
    write('-----------|         |---[NA5('), ownedTerritory(na5, _, _NA5), integerToString(_NA5, _RNA5), write(_RNA5), write(')----[EU1('), ownedTerritory(eu1, _, _EU1), integerToString(_EU1, _REU1), print(_REU1), print(')]-[EU2('), ownedTerritory(eu2, _, _EU2), integerToString(_EU2, _REU2), print(_REU2), print(')]---------[AS1('), ownedTerritory(as1, _, _as1), integerToString(_as1, _Ras1), write(_Ras1), write(')] [AS2('), ownedTerritory(as2, _, _as2), integerToString(_as2, _Ras2), write(_Ras2), write(')] [AS3(') , ownedTerritory(as3, _, _AS3), integerToString(_AS3, _RAS3), write(_RAS3), write(')]------\n'),
    write('#       [NA3('), ownedTerritory(na3, _, _NA3), integerToString(_NA3, _RNA3), write(_RNA3), write(')]-[NA4('), ownedTerritory(na4, _, _NA4), integerToString(_NA4, _RNA4), write(_RNA4), write(')]       #       |       |         #        |          |         |            #'), nl,
    write('#          |                        #    [E3('), ownedTerritory(eu3, _, _EU3), integerToString(_EU3, _REU3), write(_REU3), write(')]-[E4('), ownedTerritory(eu4, _, _EU4), integerToString(_EU4, _REU4), write(_REU4),write(')]  ####     |          |         |            #'), nl, 
    write('###########|#########################       |       |-[E5('),  ownedTerritory(eu5, _, _EU5), integerToString(_EU5, _REU5), write(_REU5), write(')]-----[AS4('), ownedTerritory(as4, _, _AS4), integerToString(_AS4, _RAS4), write(_RAS4), write(')]----+------[AS5('), ownedTerritory(as5, _, _AS5), integerToString(_AS5, _RAS5), write(_RAS5), write(')]      #'),nl,
    write('#          |                        ########|#######|#############                |                      #'), nl,
    write('#       [SA1('), ownedTerritory(sa1, _, _SA1), integerToString(_SA1, _RSA1), write(_RSA1), write(']                   #       |       |            #                |                      #'), nl,
    write('#          |                        #       |    [AF2('), ownedTerritory(af2, _, _AF2), integerToString(_AF2, _RAF2), write(_RAF2), write(')]      #              [AS6('), ownedTerritory(as6, _, _AS6), integerToString(_AS6, _RAS6), write(_RAS6), write(']---[AS7('), ownedTerritory(as7, _, _as7), integerToString(_as7, _Ras7), write(_Ras7), write(']    #'),nl,
    write('#   |---[SA2('), ownedTerritory(sa2, _, _sa2), integerToString(_sa2, _Rsa2), write(_Rsa2), write(']-------------------------[AF1('), ownedTerritory(af1, _, _AF1), integerToString(_AF1, _RAF1), write(_RAF1), write(']---|          #                |                      #'), nl, 
    write('#   |                               #               |            #################|#######################'), nl, 
    write('#   |                               #            [AF3('), ownedTerritory(af3, _, _AF3), integerToString(_AF3, _RAF3), write(_RAF3), write(']       #                |                      #'), nl,
    write('----|                               #                            #             [AU1('), ownedTerritory(au1, _, _AU1), integerToString(_AU1, _RAU1), write(_RAU1), write(']---[AU2('), ownedTerritory(au2, _, _au2), integerToString(_au2, _Rau2), write(_Rau2), write(']------'), nl,
    write('#                                   #                            #                                       #'), nl, 
    write('#       South America               #         Africa             #          Australia                    #'), nl, 
    write('##########################################################################################################'), nl, !.

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
        getElement(NeighbouringArea, Choice, AttackedArea),
        write('Perang telah dimulai.\n'),
        ownedTerritory(AttackedArea, AttackedOwner, AttackedTroopsNumber),
        format('Player ~w\n', [CurrName]),
        rollAttackDice(0, SoldierToAttack, Sum1),
        format('Total: ~w\n\n', [Sum1]),
        format('Player ~w\n', [AttackedOwner]),
        rollAttackDice(0, AttackedTroopsNumber, Sum2),
        format('Total: ~w\n\n', [Sum2]),
        ((Sum1 > Sum2) -> (
            format('Player ~w menang! Wilayah ~w sekarang dikuasai Oleh Player ~w.\n\n', [CurrName, AttackedArea, CurrName]),
            readStayingTroops(SoldierToAttack, AttackedArea, ResSol),
            NewX is TroopsNumber - ResSol,
            NewY is ResSol,
            setOwnedTerritory(SelectedArea, CurrName, NewX),
            setOwnedTerritory(AttackedArea, CurrName, NewY),
            format('Tentara di wilayah ~w: ~w\n', [SelectedArea, NewX]),
            format('Tentara di wilayah ~w: ~w\n', [AttackedArea, NewY]),!
        ));
        (
            format('Player ~w menang! Sayang sekali, penyerangan anda gagal!\n :(\n\n', [AttackedOwner]),
            NewNew is TroopsNumber - SoldierToAttack,
            setOwnedTerritory(SelectedArea, CurrName, NewNew),
            format('Tentara di wilayah ~w: ~w\n', [SelectedArea, NewNew]),
            format('Tentara di wilayah ~w: ~w\n', [AttackedArea, AttackedTroopsNumber]),!
        )
    ));
    (write('Anda tidak bisa menyerang karena Anda memiliki tepat satu tentara\n')),!.

adjacentList(na1, [na2, na3, as3]).
adjacentList(na2, [na1, na4, na5]).
adjacentList(na3, [na1, na4, sa1]).
adjacentList(na4, [na2, na3, na5]).
adjacentList(na5, [na2, na4, eu1]).

adjacentList(sa1, [na3, sa2]).
adjacentList(sa2, [sa1, af1, au2]).

adjacentList(af1, [sa2, af2]).
adjacentList(af2, [af1, af3, eu4, eu5]).
adjacentList(af3, [af1, af2]).

adjacentList(eu1, [na5, eu2, eu3]).
adjacentList(eu2, [eu1, eu3, eu4, as1]).
adjacentList(eu3, [eu1, eu2, eu4]).
adjacentList(eu4, [eu2, eu3, eu5, af2]).
adjacentList(eu5, [eu4, af2, as4]).

adjacentList(as1, [eu2, as4]).
adjacentList(as2, [as4, as5, as6]).
adjacentList(as3, [as5, na1, na3]).
adjacentList(as4, [as1, as2, as5, es5]).
adjacentList(as5, [as2, as4, as6, as7]).
adjacentList(as6, [as2, as5, as7, au1]).
adjacentList(as7, [as5, as6]).

adjacentList(au1, [as6, au2]).
adjacentList(au2, [au1, sa2]).

ownedTerritory(as1, berto, 3).
ownedTerritory(as2, berto, 3).
ownedTerritory(as3, berto, 3).
ownedTerritory(as4, berto, 3).
ownedTerritory(as5, berto, 3).
ownedTerritory(as6, berto, 3).
ownedTerritory(as7, berto, 3).

ownedTerritory(eu1, mahew, 2).
ownedTerritory(eu2, mahew, 2).
ownedTerritory(eu3, mahew, 2).
ownedTerritory(eu4, mahew, 2).
ownedTerritory(eu5, mahew, 2).

ownedTerritory(na1, suta, 5).
ownedTerritory(na2, suta, 15).
ownedTerritory(na3, suta, 5).
ownedTerritory(na4, suta, 5).
ownedTerritory(na5, suta, 5).

ownedTerritory(sa1, kielcina, 1).
ownedTerritory(sa2, kielcina, 1).

ownedTerritory(af1, adril, 9).
ownedTerritory(af2, adril, 9).
ownedTerritory(af3, adril, 9).

ownedTerritory(au1, metiw, 5).
ownedTerritory(au2, metiw, 5).

setOwnedTerritory(TerrName, Owner, X) :- retract(ownedTerritory(TerrName, _, _)), assertz(ownedTerritory(TerrName, Owner, X)),!.