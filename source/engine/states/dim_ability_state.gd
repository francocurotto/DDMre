extends "state.gd"
## Dim Ability State.
##
## State to activate a dimension ability that requires manual input.

# constants
const NAME = "DIMABILITY"

# variables
var DungeonState = load("engine/states/dungeon_state.gd")
var summon ## Summon with dimension ability to activate.

func _init(_player, _opponent, _dungeon, _summon):
    super(_player, _opponent, _dungeon)
    summon = _summon

## Execute the SKIP command. Skip the dimension ability activation.
func SKIP(_cmddict):
    return DungeonState.new(player, opponent, dungeon)

## Execute the CAST command. Cast the dimension ability.
func CAST(cmddict):
    # get data
    var ability_dict = cmddict["ability"]
    var ability = summon.get_ability(ability_dict["name"])
    
    # activate ability
    ability.activate(ability_dict)
    
    # return dungeon state
    return DungeonState.new(player, opponent, dungeon)
