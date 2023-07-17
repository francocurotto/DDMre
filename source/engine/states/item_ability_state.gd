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

func SKIP(_cmd):
    """
    Execute the SKIP command.
    """
    return DungeonState.new(player, opponent, dungeon)

func ABILITY(cmd):
    """
    Excecute the ABILITY command.
    """
    # get data
    var activate_dict = cmd["ability_dict"]
    var ability = monster.get_ability(ability_dict["name"])

    # activate ability
    ability.activate(monster, activate_dict)
    
    Events.emit_signal("duel_update")
    return DungeonState.new(player, opponent, dungeon)
