/* FACTS */
/* Dynamic Variable */
:- dynamic(ownedTerritory/3). /* teritoryCode, ownerName, troopsCount */
:- dynamic(ownedContinent/2). /* continentName, ownerName */

/* Dummyu Insertion Of OwnedTerritory */
ownedTerritory(as1, berto, 3).
ownedTerritory(as2, suta, 3).
ownedTerritory(as3, adril, 7).
ownedTerritory(as4, berto, 10).
ownedTerritory(as5, berto, 8).
ownedTerritory(as6, mahew, 4).
ownedTerritory(as7, berto, 1).

ownedTerritory(eu1, mahew, 2).
ownedTerritory(eu2, adril, 8).
ownedTerritory(eu3, berto, 1).
ownedTerritory(eu4, adril, 10).
ownedTerritory(eu5, mahew, 3).

ownedTerritory(na1, suta, 5).
ownedTerritory(na2, berto, 15).
ownedTerritory(na3, mahew, 4).
ownedTerritory(na4, mahew, 7).
ownedTerritory(na5, suta, 1).

ownedTerritory(sa1, berto, 4).
ownedTerritory(sa2, adril, 6).

ownedTerritory(af1, adril, 8).
ownedTerritory(af2, adril, 6).
ownedTerritory(af3, adril, 2).

ownedTerritory(au1, mahew, 12).
ownedTerritory(au2, mahew, 3).

/* Dummy Insertion of ownedContinent*/
ownedContinent(asia, berto).
ownedContinent(asia, suta).
ownedContinent(asia, adril).
ownedContinent(asia, mahew).
ownedContinent(europe, mahew).
ownedContinent(europe, berto).
ownedContinent(europe, adril).
ownedContinent(north_america, mahew).
ownedContinent(north_america, berto).
ownedContinent(north_america, suta).
ownedContinent(south_america, adril).
ownedContinent(south_america, berto).
ownedContinent(africa, adril).
ownedContinent(australia, mahew).

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

/* return how many territory in Continent*/
countTerritoryInContinent(Continent,Count):-
    findall(Territory,territoryContinent(Continent,Territory),TerritoryList),
    length(TerritoryList,Count).

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
    findall(TerritoryContinent,territoryContinent(Continent,TerritoryContinent),TerritoryContinentList),
    listSameElements(TerritoryContinentList,TerritoryOwnList,ListOwn).

/* display Own Cotinent detail for checkPlayerTerritories */
displayOwnContinent(Name,Continent):-
    countOwnedTerritoriesInContinent(Name,Continent,SumOwnedInContinent),
    countTerritoryInContinent(Continent,SumTerritoryInContinent),
    write('Benua '),write(Continent),write(' ('),write(SumOwnedInContinent),write('/'),write(SumTerritoryInContinent),write(')'),nl,
    listOwnedTerritoriesInContinent(Name,Continent,ListOwn),
    displayOwnTerritories(ListOwn,Name).

/* display Own Territories for checkPlayerTerritories */
displayOwnTerritories([],Name).
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