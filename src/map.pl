/* FACTS */
/* Dynamic Variable */
:- dynamic(ownedTerritory/3).
:- dynamic(mapName/2).
:- dynamic(ownedContinent/2).

/* Dummyu Insertion Of OwnedTerritory */
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

/* slang territory name */
territoryName(na1,north_america).
territoryName(na2,north_america).
territoryName(na3,north_america).
territoryName(na4,north_america).
territoryName(na5,north_america).

territoryName(e1,europe).
territoryName(e2,europe).
territoryName(e3,europe).
territoryName(e4,europe).
territoryName(e5,europe).

territoryName(a1,asia).
territoryName(a2,asia).
territoryName(a3,asia).
territoryName(a4,asia).
territoryName(a5,asia).
territoryName(a6,asia).
territoryName(a7,asia).

territoryName(sa1,south_america).
territoryName(sa2,south_america).

territoryName(af1,africa).
territoryName(af2,africa).
territoryName(af3,africa).

territoryName(au1,australia).
territoryName(au2,australia).
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

integerToString(X, Y) :- X < 10, number_codes(X, Codes), atom_codes(String, Codes), atom_concat('00', String, Y), !.
integerToString(X, Y) :- X < 100, number_codes(X, Codes), atom_codes(String, Codes), atom_concat('0', String, Y), !.
integerToString(X, Y) :- Y is X,!. 

displayMap :- 
    nl,
    write('#####################################################################################################\n'),
    write('#           North America           #        Europe         #                 Asia                  #\n'),
    write('#                                   #                       #                                       #\n'),
    write('#       [NA1('), ownedTerritory(na1, _, _NA1), integerToString(_NA1, _RNA1), write(_RNA1), write(')]-[NA2('), ownedTerritory(na2, _, _NA2), integerToString(_NA2, _RNA2), write(_RNA2), write(')]       #                       #                                       #\n'),
    write('-----------|         |---[NA5('), ownedTerritory(na5, _, _NA5), integerToString(_NA5, _RNA5), write(_RNA5), write(')----[EU1('), ownedTerritory(eu1, _, _EU1), integerToString(_EU1, _REU1), print(_REU1), print(')]-[EU2('), ownedTerritory(eu2, _, _EU2), integerToString(_EU2, _REU2), print(_REU2), print(')]-----[AS1(001)] [AS2(013)] [AS3(003)]-----\n').