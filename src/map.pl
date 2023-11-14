/* FACTS */
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
adjacent(eu1, eu2).
adjacent(eu1, eu3).
adjacent(eu1, na5).
adjacent(eu2, as1).
adjacent(eu2, eu1).
adjacent(eu2, eu4).
adjacent(eu3, af1).
adjacent(eu3, eu4).
adjacent(su3, eu1).
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