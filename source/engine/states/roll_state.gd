extends "state.gd"

const NAME = "ROLL"

func _init(_player, _opponent).(_player, _opponent):
	cmdlist += ["ROLL"]
	# connect signals
	for dice in player.dicepool:
		dice.connect("rolled", player.crestpool, "add_crests")

func ROLL(cmd):
	var dicelist = get_dicelist(cmd["dice"])
	roll_dice(dicelist)
	
func get_dicelist(indeces):
	"""
	Get a liist of dice from a list of indeces
	"""
	var dicelist = []
	for i in indeces:
		dicelist.append(player.dicepool[i])
	return dicelist

func roll_dice(dicelist):
	"""
	Roll an array of dice.
	"""
	var sides = []
	for dice in dicelist:
		dice.roll()
