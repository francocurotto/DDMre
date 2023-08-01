extends "state.gd"
## Reply State.
##
## State where the player reply to a an attack from an opponent monster to one
## of its monster.

# constants
const NAME = "REPLY"

# variables
var DungeonState = load("engine/states/dungeon_state.gd")
var attacker ## Attacking monster
var attacked ## Monster receiving the attack

func _init(_player, _opponent, _dungeon, _attacker, _attacked):
    super(_player, _opponent, _dungeon)
    attacker = _attacker
    attacked = _attacked

# public functions
## Excecute the GUARD command. Guard attack from opponent monster and
## optionally activate a reply ability.
func GUARD(cmddict):
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

## Excecute the WAIT command. Do not guard attack from opponent monster and
## optionally activate a reply ability.
func WAIT(cmddict):
    # get data
    var ability_dict = cmddict.get("ability")
    
    # activate attack ability if exists
    if ability_dict:
        var ability = attacked.get_ability(ability_dict["name"])
        ability.activate(attacker, ability_dict)
    
    # wait attack
    attacker.attack_monster(attacked, false)
    
    # return opponent dungeon state
    return DungeonState.new(opponent, player, dungeon)
