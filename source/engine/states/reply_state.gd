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
    cmdlist += ["GUARD", "WAIT"]

# public functions
func GUARD(cmd):
    """
    Excecute the GUARD command.
    """
    attacker.attack_monster(attacked, true)
    emit_signal("duel_update", cmd["name"])
    return DungeonState.new(opponent, player, dungeon)

func WAIT(cmd):
    """
    Excecute the WAIT command.
    """
    attacker.attack_monster(attacked, false)
    emit_signal("duel_update", cmd["name"])
    return DungeonState.new(opponent, player, dungeon)

func get_monsters_poss():
    """
    Returns the positions of the attaker and the attacked monsters in an
    array.
    """
    var poss = []
    poss.append(dungeon.get_dungobj_pos(attacker))
    poss.append(dungeon.get_dungobj_pos(attacked))
    return poss
