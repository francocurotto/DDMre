extends "state.gd"

# constants
const NAME = "ITEMABILITY"

# variables
var item
var monster
var DungeonState = load("engine/states/dungeon_state.gd")

func _init(_player, _opponent, _dungeon, _item, _monster).(_player, _opponent, _dungeon):
    item = _item
    monster = _monster

func SKIP(_cmddict):
    """
    Execute the SKIP command.
    """
    return DungeonState.new(player, opponent, dungeon)

func CAST(cmddict):
    """
    Excecute the CAST command.
    """
    # get data
    var ability_dict = cmddict["ability"]
    var ability = item.get_ability(ability_dict["name"])
    
    # activate ability
    ability.activate(monster, ability_dict)
    
    # return dungeon state
    return DungeonState.new(player, opponent, dungeon)
