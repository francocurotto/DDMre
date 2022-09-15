extends "state.gd"

# constants
const NAME = "ROLL"

# variables
var DungeonState = load("engine/states/dungeon_state.gd")

# signals
signal dice_rolled(sides)

func _init(_player, _opponent, _dungeon).(_player, _opponent, _dungeon):
    # reset player monster cooldown
    for monster in player.monsters:
        monster.cooldown = false

# public functions
func ROLL(cmd):
    """
    Execute the ROLL command.
    """
    var dicelist = get_dicelist(cmd["dice"])
    roll_dice(dicelist)
    emit_signal("duel_update", cmd["name"])
    return DungeonState.new(player, opponent, dungeon)

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
