endTurn:-
    frontName(Name),
    write("Player "), write(Name), write(" mengakhiri giliran."),
    nl,nl,
    assertz(queueName(Name)),
    retract(queueName(Name)),
    write("Sekarang giliran Player "), write(Name), write("!"),
    nl,
    write("Player "), write(Name), write("mendapatkan "),
    write("( )"), # Tunggu Adril buat
    write("tentara tambahan."),
    nl.
