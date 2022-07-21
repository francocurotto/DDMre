extends "state.gd"

const NAME = "ROLL"

var DungeonState = load("engine/states/dungeon_state.gd")

signal dice_rolled(sides)

func _init(_player, _opponent).(_player, _opponent):
    cmdlist += ["ROLL"]

func ROLL(cmd):
    var dicelist = get_dicelist(cmd["dice"])
    roll_dice(dicelist)
    return DungeonState.new(player, opponent)
    
func get_dicelist(indeces):
    """
    Get a list of dice from a list of indeces
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
        sides.append(dice.roll())
    emit_signal("dice_rolled", sides)
