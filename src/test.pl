pemain([Berto,Sutha,Adril,Matthew]).
get_element(Index, Element, List) :-
    nth0(Index, List, Element).

startGame:-
    write("Masukkan jumlah pemain: "),
    read(JumlahPemain),
    write("Mohon masukkan angka antara 2 - 4.").