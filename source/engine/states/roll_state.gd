extends "state.gd"
## Roll State.
##
## State where the player rolls a group of three dice to try to get crests 
## and/or dimension a dice.

#region constants
const NAME = "ROLL"
#endregion

#region variables
var DungeonState = load("engine/states/dungeon_state.gd")
var DimensionState = load("engine/states/dimension_state.gd")
#endregion

#region public functions
## Excecute the ROLL command. Roll three dice and depending on the results, go
## to dimension state or dungeon state.
func ROLL(cmddict):
    # get data
    var dice_indeces = cmddict["dice"]

    # roll dice
    var sides = roll_dice(dice_indeces)
    player.crestpool.add_rolled_sides(sides)
    Events.dice_rolled.emit(sides)
     
    # decide to go to dungeon or dimension state
    var dim_candidates = get_dim_candidates(dice_indeces, sides)
    if dim_candidates:
        return DimensionState.new(player, opponent, dungeon, dim_candidates)
    else:
        return DungeonState.new(player, opponent, dungeon)
#endregion

#region private functions
## Roll dice from player dicepool given the [param dice_indeces] array of dice
## indeces. Return the resulted sides of the roll.
func roll_dice(dice_indeces):
    var dice_trio = dice_indeces.map(func(i): return player.dicepool[i])
    var sides = dice_trio.map(func(dice): return dice.roll())
    return sides

## Given [param indeces] array of dice indeces and [param sides] array of sides
## results of a roll, return an array of dice indeces that are candidates for
## dimension. If no dimension candidates, return an empty array.
func get_dim_candidates(indeces, sides):
    for level in range(1,5):
        var dim_candidates = []
        for i in range(sides.size()):
            if sides[i].crest.TYPE=="SUMMON" and sides[i].mult==level:
                dim_candidates.append(indeces[i])
        if dim_candidates.size()>=2:
            return dim_candidates
    return []
#endregion
