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
func GUARD(_cmd):
    """
    Excecute the GUARD command.
    """
    player.crestpool.slots["DEFENSE"] -= 1
    attacker.attack_monster(attacked, true)
    Events.emit_signal("duel_update")
    return DungeonState.new(opponent, player, dungeon)

func WAIT(_cmd):
    """
    Excecute the WAIT command.
    """
    attacker.attack_monster(attacked, false)
    Events.emit_signal("duel_update")
    return DungeonState.new(opponent, player, dungeon)
