extends "state.gd"
## Item Ability State.
##
## State to activate an item ability that requires manual input.

# constants
const NAME = "ITEMABILITY"

# variables
var DungeonState = load("engine/states/dungeon_state.gd")
var item    ## Item with the ability to activate.
var monster ## Monster that activated the item.

func _init(_player, _opponent, _dungeon, _item, _monster):
    super(_player, _opponent, _dungeon)
    item = _item
    monster = _monster

## Execute the SKIP command. Skip the item ability activation.
func SKIP(_cmddict):
    return DungeonState.new(player, opponent, dungeon)

## Execute the CAST command. Cast the item ability.
func CAST(cmddict):
    # get data
    var ability_dict = cmddict["ability"]
    var ability = item.get_ability(ability_dict["name"])
    
    # activate ability
    ability.activate(monster, ability_dict)
    
    # return dungeon state
    return DungeonState.new(player, opponent, dungeon)
