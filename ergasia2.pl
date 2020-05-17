pair_list([], []).
pair_list([FirstElement, SecondElement | Tail], [[FirstElement, SecondElement] | Remaining]) :- pair_list(Tail, Remaining).