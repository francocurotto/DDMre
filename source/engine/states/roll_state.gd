extends "state.gd"

# constants
const NAME = "ROLL"

# variables
var DungeonState = load("engine/states/dungeon_state.gd")

# signals
signal dice_rolled(sides)

func _init(_player, _opponent).(_player, _opponent):
    cmdlist += ["ROLL"]

# public functions
func ROLL(cmd):
    """
    Execute the ROLL command.
    """
    var dicelist = get_dicelist(cmd["dice"])
    roll_dice(dicelist)
    return DungeonState.new(player, opponent)

# private functions
func get_dicelist(indeces):
    """
    Get a list of player dice from a list of indeces.
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
