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
territoryName(na,north_america).
territoryName(e,europe).
territoryName(a,asia).
territoryName(sa,south_america)
territoryName(af,africa).
territoryName(au,australia).

/* Adjacent Territory*/
adjacent(as1, eu2)
adjacent(as1, as4)