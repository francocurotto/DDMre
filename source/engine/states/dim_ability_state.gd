extends "state.gd"
## Dim Ability State.
##
## State to activate a dimension ability that requires manual input.

#region constants
const NAME = "DIMABILITY"
#endregion

#region variables
var DungeonState = load("engine/states/dungeon_state.gd")
var summon ## Summon with dimension ability to activate.
#endregion

#region builtin functions
func _init(_player, _opponent, _dungeon, _summon):
    super(_player, _opponent, _dungeon)
    summon = _summon
#endregion

#region public functions
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
#endregion
