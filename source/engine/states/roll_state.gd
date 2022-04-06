extends "state.gd"

const NAME = "ROLL"

func _init(stateplayer, stateopponent).(stateplayer, stateopponent):
	cmdlist += ["ROLL"]

func ROLL(cmd):
	print(cmd)
