extends Node

var day : int = 1;
var season : int = 1;
var temp : float = 0;

func new_day():
	day += 1;
	if day > 28:
		day = 1;
		season += 1;
		if season > 4:
			season = 1;
	print("day:" + str(day) + "season:" + str(season))
