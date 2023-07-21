extends "state.gd"

# constants
const NAME = "DIMABILITY"

# variables
var summon
var DungeonState = load("engine/states/dungeon_state.gd")

func _init(_player, _opponent, _dungeon, _summon).(_player, _opponent, _dungeon):
    summon = _summon

func SKIP(_cmddict):
    """
    Execute the SKIP command.
    """
    return DungeonState.new(player, opponent, dungeon)

func ABILITY(cmddict):
    """
    Excecute the ABILITY command.
    """
    # get data
    var ability_dict = cmddict["ability"]
    var ability = summon.get_ability(ability_dict["name"])
    
    # activate ability
    ability.activate(ability_dict)
    
    # return dungeon state
    return DungeonState.new(player, opponent, dungeon)
