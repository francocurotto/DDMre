extends "state.gd"

# constants
const NAME = "REPLY"

# variables
var DungeonState = load("engine/states/dungeon_state.gd")
var attacker
var attacked

func _init(_player, _opponent, _dungeon, _attacker, _attacked).(_player, _opponent, _dungeon):
    attacker = _attacker
    attacked = _attacked

# public functions
func GUARD(cmd):
    """
    Excecute the GUARD command.
    """
    var ability_dict = cmd.get("ability_dict")
    # activate attack ability if exists
    if ability_dict:
        attacked.activate_reply_ability(attacker, ability_dict)
    player.crestpool.slots["DEFENSE"] -= 1
    attacker.attack_monster(attacked, true)
    Events.emit_signal("duel_update")
    return DungeonState.new(opponent, player, dungeon)

func WAIT(cmd):
    """
    Excecute the WAIT command.
    """
    var ability_dict = cmd.get("ability")
    # activate attack ability if exists
    if ability_dict:
        attacked.activate_reply_ability(attacker, ability_dict)
    attacker.attack_monster(attacked, false)
    Events.emit_signal("duel_update")
    return DungeonState.new(opponent, player, dungeon)
