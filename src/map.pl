/* FACTS */
/* Dynamic Variable */
:- dynamic(ownedTerritory/3). /* teritoryCode, ownerName, troopsCount */
:- dynamic(ownedContinent/2). /* continentName, ownerName */


/* Dummyu Insertion Of OwnedTerritory */
% ownedTerritory(as1, berto, 3).
% ownedTerritory(as2, berto, 3).
% ownedTerritory(as3, berto, 3).
% ownedTerritory(as4, berto, 3).
% ownedTerritory(as5, berto, 3).
% ownedTerritory(as6, berto, 3).
% ownedTerritory(as7, berto, 3).

% ownedTerritory(eu1, mahew, 2).
% ownedTerritory(eu2, mahew, 2).
% ownedTerritory(eu3, mahew, 2).
% ownedTerritory(eu4, mahew, 2).
% ownedTerritory(eu5, mahew, 2).

% ownedTerritory(na1, suta, 5).
% ownedTerritory(na2, suta, 15).
% ownedTerritory(na3, suta, 5).
% ownedTerritory(na4, suta, 5).
% ownedTerritory(na5, suta, 5).

% ownedTerritory(sa1, kielcina, 1).
% ownedTerritory(sa2, kielcina, 1).

% ownedTerritory(af1, adril, 9).
% ownedTerritory(af2, adril, 9).
% ownedTerritory(af3, adril, 9).

% ownedTerritory(au1, metiw, 5).
% ownedTerritory(au2, metiw, 5).

% /* Dummy Insertion of ownedContinent*/
% ownedContinent(asia, berto).
% ownedContinent(asia, matthew).
% ownedContinent(europe, berto).
% ownedContinent(north_america, berto).
% ownedContinent(south_america, matthew).
% ownedContinent(africa, berto).
% ownedContinent(australia, berto).

/* Continent*/
continent(asia).
continent(north_america).
continent(europe).
continent(south_america).
continent(australia).
continent(africa).

/* Continent of the territory */
territoryContinent(asia, as1).
territoryContinent(asia, as2).
territoryContinent(asia, as3).
territoryContinent(asia, as4).
territoryContinent(asia, as5).
territoryContinent(asia, as6).
territoryContinent(asia, as7).

territoryContinent(europe, eu1).
territoryContinent(europe, eu2).
territoryContinent(europe, eu3).
territoryContinent(europe, eu4).
territoryContinent(europe, eu5).

territoryContinent(north_america, na1).
territoryContinent(north_america, na2).
territoryContinent(north_america, na3).
territoryContinent(north_america, na4).
territoryContinent(north_america, na5).

territoryContinent(south_america, sa1).
territoryContinent(south_america, sa2).

territoryContinent(africa, af1).
territoryContinent(africa, af2).
territoryContinent(africa, af3).

territoryContinent(australia, au1).
territoryContinent(australia, au2).

territoryName(na1, canada).
territoryName(na2, usa).
territoryName(na3, mexico).
territoryName(na4, greenland).
territoryName(na5, cuba).

territoryName(eu1, italy).
territoryName(eu2, germany).
territoryName(eu3, uk).
territoryName(eu4, france).
territoryName(eu5, netherland).

territoryName(as1, japan).
territoryName(as2, china).
territoryName(as3, indonesia).
territoryName(as4, india).
territoryName(as5, thailand).
territoryName(as6, philippines).
territoryName(as7, singapore).

territoryName(sa1, brazil). 
territoryName(sa2, argentina).

territoryName(af1, nigeria).
territoryName(af2, kenya).
territoryName(af3, niger).

territoryName(au1, australia).
territoryName(au2, newzealand).

/* Adjacent Territory*/
adjacent(as1, as4).
adjacent(as1, eu2).
adjacent(as2, as6).
adjacent(as2, as4).
adjacent(as2, as5).
adjacent(as3, as5).
adjacent(as3, na1).
adjacent(as3, na3).
adjacent(as4, as1).
adjacent(as4, eu5).
adjacent(as4, as5).
adjacent(as4, as2).
adjacent(as4, as6).
adjacent(as5, as4).
adjacent(as5, as2).
adjacent(as5, as6).
adjacent(as5, as3).
adjacent(as6, as7).
adjacent(as6, as2).
adjacent(as6, as4).
adjacent(as6, as5).
adjacent(as6, au1).
adjacent(as7, as6).
adjacent(au1, as6).
adjacent(au1, au2).
adjacent(au2, sa2).
adjacent(au2, au1).
adjacent(eu1, eu2).
adjacent(eu1, eu3).
adjacent(eu1, na5).
adjacent(eu2, as1).
adjacent(eu2, eu1).
adjacent(eu2, eu4).
adjacent(eu3, af1).
adjacent(eu3, eu4).
adjacent(eu3, eu1).
adjacent(eu4, eu2).
adjacent(eu4, eu3).
adjacent(eu4, eu5).
adjacent(eu4, af2).
adjacent(eu5, eu4).
adjacent(eu5, as4).
adjacent(eu5, af2).
adjacent(af1, eu3).
adjacent(af1, af2).
adjacent(af1, af3).
adjacent(af1, sa2).
adjacent(af2, eu4).
adjacent(af2, eu5).
adjacent(af2, af1).
adjacent(af2, af3).
adjacent(na1, na2).
adjacent(na1, as3).
adjacent(na1, na3).
adjacent(na2, na1).
adjacent(na2, na4).
adjacent(na2, na5).
adjacent(na3, na1).
adjacent(na3, na4).
adjacent(na3, sa1).
adjacent(na3, as3).
adjacent(na4, na3).
adjacent(na4, na2).
adjacent(na4, na5).
adjacent(na5, na2).
adjacent(na5, na4).
adjacent(na5, eu1).
adjacent(sa1, na3).
adjacent(sa1, sa2).
adjacent(sa2, sa1).
adjacent(sa2, af1).
adjacent(sa2, au2).

/* Adjacent List */
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


displayMap :- 
    nl,
    write('##########################################################################################################\n'),
    write('#           North America           #        Europe           #                 Asia                     #\n'),
    write('#                                   #                         #                                          #\n'),
    write('#       [NA1('), (ownedTerritory(na1, _, _NA1) -> integerToString(_NA1, _RNA1); _RNA1 = '000'), write(_RNA1), write(')]-[NA2('), (ownedTerritory(na2, _, _NA2) -> integerToString(_NA2, _RNA2); _RNA2 = '000'), write(_RNA2), write(')]       #                         #                                          #\n'),
    write('-----------|         |---[NA5('), (ownedTerritory(na5, _, _NA5) -> integerToString(_NA5, _RNA5); _RNA5 = '000'), write(_RNA5), write(')]---[EU1('), (ownedTerritory(eu1, _, _EU1) -> integerToString(_EU1, _REU1) ; _REU1 = '000'), print(_REU1), print(')]-[EU2('), (ownedTerritory(eu2, _, _EU2) -> integerToString(_EU2, _REU2); _REU2 = '000'), print(_REU2), print(')]---------[AS1('), (ownedTerritory(as1, _, _as1) -> integerToString(_as1, _Ras1); _Ras1 = '000'), write(_Ras1), write(')] [AS2('), (ownedTerritory(as2, _, _as2) -> integerToString(_as2, _Ras2) ; _Ras2 = '000'), write(_Ras2), write(')] [AS3(') , (ownedTerritory(as3, _, _AS3) -> integerToString(_AS3, _RAS3); _RAS3 = '000'), write(_RAS3), write(')]------\n'),
    write('#       [NA3('), (ownedTerritory(na3, _, _NA3) -> integerToString(_NA3, _RNA3); _RNA3 = '000'), write(_RNA3), write(')]-[NA4('), (ownedTerritory(na4, _, _NA4) -> integerToString(_NA4, _RNA4); _RNA4 = '000'), write(_RNA4), write(')]       #       |       |         #        |          |         |            #'), nl,
    write('#          |                        #    [E3('), (ownedTerritory(eu3, _, _EU3) -> integerToString(_EU3, _REU3); _REU3 = '000'), write(_REU3), write(')]-[E4('), (ownedTerritory(eu4, _, _EU4) -> integerToString(_EU4, _REU4); _REU4 = '000'), write(_REU4),write(')]  ####     |          |         |            #'), nl, 
    write('###########|#########################       |       |-[E5('),  (ownedTerritory(eu5, _, _EU5) -> integerToString(_EU5, _REU5); _REU5 = '000'), write(_REU5), write(')]-----[AS4('), (ownedTerritory(as4, _, _AS4) -> integerToString(_AS4, _RAS4); _RAS4 = '000'), write(_RAS4), write(')]----+------[AS5('), (ownedTerritory(as5, _, _AS5) -> integerToString(_AS5, _RAS5); _RAS5 = '000'), write(_RAS5), write(')]      #'),nl,
    write('#          |                        ########|#######|#############                |                      #'), nl,
    write('#       [SA1('), (ownedTerritory(sa1, _, _SA1) -> integerToString(_SA1, _RSA1); _RSA1 = '000'), write(_RSA1), write(')]                  #       |       |            #                |                      #'), nl,
    write('#          |                        #       |    [AF2('), (ownedTerritory(af2, _, _AF2) -> integerToString(_AF2, _RAF2); _RAF2 = '000'), write(_RAF2), write(')]      #              [AS6('), (ownedTerritory(as6, _, _AS6) -> integerToString(_AS6, _RAS6); _RAS6 = '000'), write(_RAS6), write(')]--[AS7('), (ownedTerritory(as7, _, _as7) -> integerToString(_as7, _Ras7); _Ras7 = '000'), write(_Ras7), write(')]   #'),nl,
    write('#   |---[SA2('), (ownedTerritory(sa2, _, _sa2) -> integerToString(_sa2, _Rsa2); _Rsa2 = '000'), write(_Rsa2), write(')]------------------------[AF1('), (ownedTerritory(af1, _, _AF1) -> integerToString(_AF1, _RAF1); _RAF1 = '000'), write(_RAF1), write(')]--|          #                |                      #'), nl, 
    write('#   |                               #               |            #################|#######################'), nl, 
    write('#   |                               #            [AF3('), (ownedTerritory(af3, _, _AF3) -> integerToString(_AF3, _RAF3); _RAF3 = '000'), write(_RAF3), write(')]      #                |                      #'), nl,
    write('----|                               #                            #             [AU1('), (ownedTerritory(au1, _, _AU1) -> integerToString(_AU1, _RAU1); _RAU1 = '000'), write(_RAU1), write(')]--[AU2('), (ownedTerritory(au2, _, _au2) -> integerToString(_au2, _Rau2); _Rau2 = '000'), write(_Rau2), write(')]-----'), nl,
    write('#                                   #                            #                                       #'), nl, 
    write('#       South America               #         Africa             #          Australia                    #'), nl, 
    write('##########################################################################################################'), nl, !.


/* return how many territory in Continent*/
countTerritoryInContinent(Continent,Count):-
    findall(Territory,territoryContinent(Continent,Territory),TerritoryList),
    length(TerritoryList,Count).

/* Set the owner territory */
setOwnedTerritory(TerrName, Owner, X) :- retract(ownedTerritory(TerrName, _, _)), assertz(ownedTerritory(TerrName, Owner, X)),!.

/* list of all teritory owned by a player */
ownedTeritories(Owner, Territories):-
    findall(Territory, ownedTerritory(Territory, Owner, _), Territories),!.

/* count How many Owner have territories */
countOwnedTerritories(Owner, Count):-
    findall(Territories, ownedTerritory(Territories, Owner, _), OwnedTerritories),
    length(OwnedTerritories,Count).

/* list all continent that Owner own in Continents*/
allOwnedContinent(Owner, Continents):-
    findall(Continent, ownedContinent(Continent, Owner), Continents).

/* count placed Soldier in Map */
countPlacedSoldier(Owner,Count):-
    findall(Soldier, ownedTerritory(_, Owner, Soldier), SoldierList),
    countOwnedTerritories(Owner, SumTerritories),
    sumUntil(SoldierList, SumTerritories - 1, Count).

/* count all owned territories in continent */
countOwnedTerritoriesInContinent(Owner,Continent,Count):-
    findall(Territory, ownedTerritory(Territory,Owner,_),TerritoryOwnList),
    findall(TerritoryContinent,territoryContinent(Continent,TerritoryContinent),TerritoryContinentList),
    countElements(TerritoryOwnList,TerritoryContinentList,Count).

/* list owned territories in continent */
listOwnedTerritoriesInContinent(Owner, Continent, ListOwn):-
    findall(Territory, ownedTerritory(Territory,Owner,_),TerritoryOwnList),
    findall(TerritoryContinent,territoryContinent(Continent, TerritoryContinent),TerritoryContinentList),
    listSameElements(TerritoryContinentList,TerritoryOwnList,ListOwn).

/* display Own Cotinent detail for checkPlayerTerritories */
displayOwnContinent(Name,Continent):-
    countOwnedTerritoriesInContinent(Name,Continent,SumOwnedInContinent),
    countTerritoryInContinent(Continent,SumTerritoryInContinent),
    write('Benua '),write(Continent),write(' ('),write(SumOwnedInContinent),write('/'),write(SumTerritoryInContinent),write(')'),nl,
    listOwnedTerritoriesInContinent(Name,Continent,ListOwn),
    displayOwnTerritories(ListOwn,Name).

/* display Own Territories for checkPlayerTerritories */
displayOwnTerritories([],_).
displayOwnTerritories([Head,[]],Name):-
    write(Head),nl,
    territoryName(Head, NameTerritory),
    ownedTerritory(Head,Name,PlacedSoldier),
    write('Nama                 : '), write(NameTerritory),nl,
    write('Jumlah tentara       : '), write(PlacedSoldier),nl,nl.

displayOwnTerritories([Head|Tail],Name):-
    write(Head),nl,
    territoryName(Head, NameTerritory),
    ownedTerritory(Head,Name,PlacedSoldier),
    write('Nama                 : '), write(NameTerritory),nl,
    write('Jumlah tentara       : '), write(PlacedSoldier),nl,nl,
    displayOwnTerritories(Tail,Name),!.