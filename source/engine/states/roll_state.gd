extends "state.gd"

# constants
const NAME = "ROLL"

# variables
var DungeonState = load("engine/states/dungeon_state.gd")
var DimensionState = load("engine/states/dimension_state.gd")


func _init(_player, _opponent, _dungeon).(_player, _opponent, _dungeon):
    # reset player monster cooldown
    for monster in player.monsters:
        monster.cooldown = false

# public functions
func ROLL(cmd):
    """
    Execute the ROLL command.
    """
    var sides = roll_dice(cmd["dice"])
    var dim_candidates = get_dim_candidates(cmd["dice"], sides)
    Events.emit_signal("duel_update", cmd["name"])
    if dim_candidates:
        return DimensionState.new(player, opponent, dungeon, dim_candidates)
    else:
        return DungeonState.new(player, opponent, dungeon)

# private functions
func roll_dice(indeces):
    """
    Roll dice given dice indeces.
    """
    var sides = []
    for i in indeces:
        sides.append(player.dicepool[i].roll())
    Events.emit_signal("dice_rolled", sides)
    return sides

func get_dim_candidates(indeces, sides):
    """
    Return list of dice indeces that are candidates for dimension given
    rolled sides. If no dimension candidates, returns an empty array.
    """
    for level in range(1,5):
        var dim_candidates = []
        for i in range(sides.size()):
            if sides[i].crest.is_summon() and sides[i].mult==level:
                dim_candidates.append(indeces[i])
        if dim_candidates.size()>=2:
            return dim_candidates
    return []
