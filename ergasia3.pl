:- dynamic at/2, i_am_at/1, door/2.

go:-
	write('You just arrived at the gas station and you are in your car and you want to buy a soda and a newspaper.Available commands: goto(),open(),take(),cross(),leave.'),
	prompt(_, ''),
	repeat,
	nl,
	write('> '),
	read(X),
	call(X),
	fail.

/* Initialization */
i_am_at(car).
door(car_door,closed).
door(gas_station_door,closed).

/* The location of various objects */
at(soda,gas_station).
at(newspaper,gas_station).

/* How are the locations connected */
path(car,outside_of_car):- door(car_door,opened).
path(car,outside_of_car):- door(car_door,closed),
		write('You need to open the car door first.'),fail.

path(outside_of_car,car):- door(car_door,opened).
path(outside_of_car,car):- door(car_door,closed),
		write('You need to open the car door first.'),fail.

path(gas_station,outside_of_gas_station):- door(gas_station_door,opened).
path(gas_station,outside_of_gas_station):- door(gas_station_door,closed),
		write('You need to open the gas station door first.'),fail.

path(outside_of_gas_station,gas_station):- door(gas_station_door,opened).
path(outside_of_gas_station,gas_station):- door(gas_station_door,closed),
		write('You need to open the gas station door first.'),fail.

path(outside_of_gas_station,outside_of_car):- write('You need to cross the road first.'),fail.
path(outside_of_car,outside_of_gas_station):- write('You need to cross the road first.'),fail.

exists(car,outside_of_car).
exists(outside_of_car,outside_of_gas_station).
exists(outside_of_gas_station,gas_station).
exists(gas_station,outside_of_gas_station).
exists(outside_of_gas_station,outside_of_car).
exists(outside_of_car,car).

closing(Door):- door(Door,opened),
			retract(door(Door,opened)),
			assert(door(Door,closed)).

closing(Door):- door(Door,closed).

/* Moving from one place to another */
goto(There):-
		i_am_at(Here),
		path(Here,There),
		retract(i_am_at(Here)),
		assert(i_am_at(There)),
		closing(car_door),
		closing(gas_station_door),
		write('You went to the '),write(There),write('.'),!.
goto(There):-
		i_am_at(Here),
		Here\=There,
		not(exists(Here,There)),
		write('You cannot get to the "'),write(There),write('" from the "'),write(Here),write('".'),!.

goto(There):-
		i_am_at(Here),
		Here=There,
		write('You already here.'),!.

cross(road):-
		i_am_at(outside_of_gas_station),
		retract(i_am_at(outside_of_gas_station)),
		assert(i_am_at(outside_of_car)),
		write('You crossed the road, now you are outside of your car.'),!.

cross(road):-
		i_am_at(outside_of_car),
		retract(i_am_at(outside_of_car)),
		assert(i_am_at(outside_of_gas_station)),
		write('You crossed the road,now you are outside of the gas station.'),!.

cross(road):-
		not(i_am_at(outside_of_car);(i_am_at(outside_of_gas_station))),
		write('You are not outside yet.').

/* The doors' state */
open(car_door):-
		door(car_door,closed),
		(i_am_at(car);i_am_at(outside_of_car)),
		retract(door(car_door,closed)),
		assert(door(car_door,opened)),
		write('Car door is now open.'),!.

open(car_door):-
		not(i_am_at(car);i_am_at(outside_of_car)),
		write('You cant open the car door from here.'),!.
	
open(car_door):-
		door(car_door,opened),
		write('Car door is already open.'),!.

open(gas_station_door):-
		door(gas_station_door,closed),
		(i_am_at(gas_station);i_am_at(outside_of_gas_station)),
		retract(door(gas_station_door,closed)),
		assert(door(gas_station_door,opened)),
		write('Gas station door is now open.'),!.

open(gas_station_door):-
		not(i_am_at(gas_station);i_am_at(outside_of_gas_station)),
		write('You cant open the gas station door from here.'),!.

open(gas_station_door):- door(gas_station_door,opened),
		write('The door is already open.').

open(_):- write('Such door doesnt exist.'),!.
		
/* Buying items */
take(X):-
		i_am_at(gas_station),
		at(X,gas_station),
		write('You now have a '), write(X), write('.'),!.
take(X):-
		i_am_at(gas_station),
		not(at(X,gas_station)),
		write('I do not see that item. ').

take(_):-
	not(i_am_at(gas_station)),
	write('You are not in the gas station yet.').

leave:-
		i_am_at(car),
		write('You drive away...'),!.
leave:-
		i_am_at(_),
		write('You need to get to your car first.').
