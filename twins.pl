family(person(tom, fox, date(7, may, 1950), works(bbc, 15200)),
person(ann, fox, date(9, may, 1951), unemployed),
[person(pat, fox, date(5, may, 1973), unemployed),
person(jim, fox, date(5, may, 1973), unemployed)]).

family(person(george, smith, date(1, january, 1965), works(hotel, 16600)),
person(helen, smith, date(23, november, 1971), works(hotel, 9000)),
[person(jessica, smith, date(16, march, 1993), unemployed),
person(jack, smith, date(14, july, 1995), works(policeman, 10000)),
person(liza, smith, date(14, july, 1995), works(teacher, 11400))]).

family(person(jim, halpert, date(1, october, 1978), works(salesman, 12000)),
person(pam, halpert, date(25, march, 1978), unemployed),
[person(cece, halpert, date(4, march, 2010), unemployed),
person(philip, halpert, date(27, december, 2011), unemployed)]).

child(X):-
  family(_, _, Children),
  member(X, Children).

twins(Child1,Child2) :- child(Child1),child(Child2),
    Child1=person(Onoma1,Epitheto1,Imerominia1,_), % Βάζουμε τα παιδιά ανά δύο στις δύο μεταβλητές Child1 και Child2 για να τα συγκρίνουμε.
    Child2=person(Onoma2,Epitheto2,Imerominia2,_),
    Onoma1@>Onoma2, % Συγκρίνουμε το Onoma1 με το Onoma2 για να μην τυπώνονται παραπάνω από μία φορά.
    Epitheto1=Epitheto2, % Ελέγχουμε αν έχουν το ίδιο επίθετο.
    Imerominia1=Imerominia2. % Ελέγχουμε αν έχουν την ίδια ημερομηνία γέννησης.