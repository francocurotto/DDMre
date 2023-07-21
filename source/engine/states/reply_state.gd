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
func GUARD(cmddict):
    """
    Excecute the GUARD command.
    """
    # get data
    var ability_dict = cmddict.get("ability")
    
    # activate attack ability if in command
    if ability_dict:
        var ability = attacked.get_ability(ability_dict["name"])
        ability.activate(attacker, ability_dict)

    # guard attack
    player.crestpool.remove_defense(1)
    attacker.attack_monster(attacked, true)
    
    # return opponent dungeon state
    return DungeonState.new(opponent, player, dungeon)

func WAIT(cmddict):
    """
    Excecute the WAIT command.
    """
    # get data
    var ability_dict = cmddict.get("ability")
    
    # activate attack ability if exists
    if ability_dict:
        attacked.activate_reply_ability(attacker, ability_dict)
    
    # wait attack
    attacker.attack_monster(attacked, false)
    
    # return opponent dungeon state
    return DungeonState.new(opponent, player, dungeon)
