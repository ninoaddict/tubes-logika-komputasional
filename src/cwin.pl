min2(A, B, R) :- A > B,!, R is B.
min2(A, _B, R) :- R is A,!.

calcNumerator(Idx, N, M, R) :-
    EnamN is N * 6,
    EnamM is M * 6, 
    ((Idx > EnamN) -> 
    (
        R is 0
    );
    (
        Idx1 is Idx + 1,
        TempRes is Idx - M,
        min2(TempRes, EnamM, MinRes),
        calcNumerator(Idx1, N, M, R1),
        ((MinRes > 0) -> 
        (
            R is MinRes + R1
        );
        (
            R is R1
        ))
    )),!.

calcDenominator(N, M, R) :-
    R is (5 * N + 1) * (5 * M + 1),!.

winningChance(N, M, R) :-
    calcDenominator(N, M, Denominator),
    calcNumerator(N, N, M, Numerator),
    R is (Numerator * 100)//Denominator,!.