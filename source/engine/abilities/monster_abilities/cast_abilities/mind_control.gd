extends "cast_ability.gd"
## MINDCONTROL ability.
##
## For one turn, switch the control of one opponent monster, to the monster 
## player.

#region variables
var cost    ## Cost to pay to activate abililty
var crest   ## Crest type to pay to activate ability
var monster ## Opponent monster to take control of
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability using parameters [param activate_dict]. Take control of 
## opponent monster.
func activate(activate_dict):
    Events.connect("next_turn", Callable(self, "on_next_turn"))
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    monster = dungeon.get_tile(pos).content
    monster.switch_player()

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_opponent_monsters_tiles()
#endregion

#region signals callbacks
## Return control to opponent monster.
func on_next_turn(_player, _turn):
    Events.disconnect("next_turn", Callable(self, "on_next_turn"))
    monster.switch_player()
#endregion
