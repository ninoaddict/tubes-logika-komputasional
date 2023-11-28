:- dynamic(riskCard/2) %playerName, riskCardType

riskCardList(['CEASEFIRE ORDER', 'SUPER SOLDIER SERUM', 'AUXILIARY TROOPS', 'REBELLION', 'DISEASE OUTBREAK', 'SUPPLY CHAIN ISSUE']).

riskEndBeforeTurn([1,2,5]).
riskEndAfterTurn([3,6]).

riskDraw(X):-
    random(1,7,R), X is R, !.

risk:-
    currentPlayer(Cpl),
    riskDraw(R),



handleRebellion:-
    currentPlayer(Name),
    listName(LN),
    getName(LN, Name, Index),
    