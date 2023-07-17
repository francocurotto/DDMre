extends "state.gd"

# constants
const NAME = "ROLL"

# preloads
const Checks = preload("res://engine/checks.gd")

# variables
var DungeonState = load("engine/states/dungeon_state.gd")
var DimensionState = load("engine/states/dimension_state.gd")


func _init(_player, _opponent, _dungeon).(_player, _opponent, _dungeon):
    pass

# public functions
func ROLL(cmd):
    """
    Execute the ROLL command.
    """
    # effects of dice roll
    var sides = roll_dice(cmd["dice"])
    player.crestpool.add_rolled_sides(sides)
    Events.emit_signal("duel_update")
    Events.emit_signal("dice_rolled", sides)
     
    # decide to go to dungeon or dimension state
    var dim_candidates = get_dim_candidates(cmd["dice"], sides)
    if dim_candidates:
        return DimensionState.new(player, opponent, dungeon, dim_candidates)
    else:
        return DungeonState.new(player, opponent, dungeon)

# private functions
func check_syntax_ROLL(cmd):
    # check dice in command dict
    if not "dice" in cmd:
        return false
    # check if 3 dice in roll
    elif len(cmd["dice"]) != 3:
        return false
    # check all rolled dice are different
    elif Checks.check_repeated_values(cmd["dice"]):
        return false
    # check dice are diceidx
    #GODOT4: use array any
    for diceidx in cmd["dice"]:
        print(diceidx)
        if not Checks.check_diceidx_num(diceidx):
            return false
    # all checks passed
    return true

func check_context_ROLL(cmd):
    #GODOT4 use array any
    for diceidx in cmd["dice"]:
        if player.dicepool[diceidx].dimensioned:
            return false
    return true

func roll_dice(dice_indeces):
    """
    Roll dice given dice indeces.
    """
    # GODTO4: use array map
    var sides = []
    for diceidx in dice_indeces:
        sides.append(player.dicepool[diceidx].roll())
    return sides

func get_dim_candidates(indeces, sides):
    """
    Return list of dice indeces that are candidates for dimension given
    rolled sides. If no dimension candidates, returns an empty array.
    """
    for level in range(1,5):
        var dim_candidates = []
        for i in range(sides.size()):
            if sides[i].crest.TYPE=="SUMMON" and sides[i].mult==level:
                dim_candidates.append(indeces[i])
        if dim_candidates.size()>=2:
            return dim_candidates
    return []
