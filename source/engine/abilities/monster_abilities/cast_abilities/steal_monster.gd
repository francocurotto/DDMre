extends "cast_ability.gd"
## STEALMONSTER ability.
##
## Destroy this monster and change control of an opponent monster for the rest 
## of the duel.

#region variables
var cost  ## Cost to pay to activate abililty
var crest ## Crest type to pay to activate ability
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability using parameters [param activate_dict]. Destroy monster and 
## take control of an opponent monster.
func activate(activate_dict):
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    monster.switch_player()
    var tile = summon.tile
    summon.destroy()
    tile.move_content_from(monster.tile)

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_opponent_monsters_tiles()
#endregion
