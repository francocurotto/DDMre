extends "state.gd"
## Dimension State.
##
## State where the player dimension dice in the dungeon and summon a monster or 
## item.

#region constants
const NAME = "DIMENSION"
#endregion

#region preload variables
var NetCreator = preload("res://engine/dungeon/nets/net_creator.gd")
#endregion

#region variables
var DungeonState = load("engine/states/dungeon_state.gd")
var DimAbilityState = load("engine/states/dim_ability_state.gd")
var dim_candidates ## Array of dicepool indeces with the possible dimensions
#endregion

#region builtin functions
func _init(_player, _opponent, _dungeon, _dim_candidates):
    super(_player, _opponent, _dungeon)
    dim_candidates = _dim_candidates
#endregion

#region public functions
## Excecute the SKIP command. Skip the dice dimension.
func SKIP(_cmddict):
    return DungeonState.new(player, opponent, dungeon)

## Excecute the DIM command. Dimension a dice in the dungeon given the 
## parameters in [param cmdict] dictionary. Go to Dungeon State or Dim Ability 
## State depending on the summon. 
func DIM(cmddict):
    # get data
    var diceidx = cmddict["dice"]
    var net_name = cmddict["net"]
    var pos = cmddict["pos"]
    var trans_list = cmddict["trans"]

    # create net
    var net = NetCreator.create_net(net_name, pos, trans_list)

    # dimension
    var summon = dungeon.dimension(player, net, diceidx)

    # decide to go to dungeon or dim ability state
    if summon.has_dim_manual_ability():
        return DimAbilityState.new(player, opponent, dungeon, summon)
    else:
        return DungeonState.new(player, opponent, dungeon)
#endregion
