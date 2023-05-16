extends "state.gd"

# constants
const NAME = "DIMABILITY"

# variables
var summon
var DungeonState = load("engine/states/dungeon_state.gd")

func _init(_player, _opponent, _dungeon, _summon).(_player, _opponent, _dungeon):
    summon = _summon

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
    for ability in summon.card.abilities:
        if ability.name == activate_dict["name"]:
            ability.activate(activate_dict)
    Events.emit_signal("duel_update")
    return DungeonState.new(player, opponent, dungeon)
