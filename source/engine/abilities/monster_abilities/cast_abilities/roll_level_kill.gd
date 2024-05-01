extends "cast_ability.gd"
## ROLLLEVELKILL ability.
##
## Move monster through a straight line of path tiles in the dungeon, and 
## destroy all summons in path path of a certain level or below. Stop movement
## when monster reaches an open tile, or a summon above that level.

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
## Activate ability using parameters [param activate_dict]. Roll monster 
## thorugh dungeon and destroy summons in the path. The level of the summons to
## destroy is defined in the [param activate_dict].
func activate(activate_dict):
    var level = activate_dict["level"]
    var total_cost = cost + level
    pay_crests(crest, total_cost)
    var roll_tiles = get_roll_tiles(activate_dict["direction"])
    
    # roll loop
    var last_empty = summon.tile
    for tile in roll_tiles:
        var roll_summon = tile.content
        if tile.is_empty():
            last_empty = tile
        elif not is_passable(roll_summon) and roll_summon.card.level<=level:
            roll_summon.destroy()
            last_empty = tile
        elif not is_passable(roll_summon) and roll_summon.card.level>level:
            break
    last_empty.move_content_from(summon.tile)
#endregion

#region is functions
## Return true if a position [param pos] in dungeon can be reached by the 
## ability. A position can be reached by the roll if it is a path tile and does 
## not contain a monster lord. 
func is_pos_rollable(pos):
    if not dungeon.pos_within_dungeon(pos):
        return false
    var tile = dungeon.get_tile(pos)
    return tile.is_path() and not tile.content.is_monster_lord()

## Return true if the ability can pass through a [param roll_summon] without 
## affecting it. Flying monsters are not affected by ability. 
func is_passable(roll_summon):
    return roll_summon.has_active_ability("FLY")
#endregion

#region private functions
## Get tiles of the path that monster will take during ability activation, 
## taking specific [param direction] in dungeon.
func get_roll_tiles(direction):
    var pos = summon.tile.pos + direction
    var tiles = []
    while is_pos_rollable(pos):
        tiles.append(dungeon.get_tile(pos))
        pos = pos + direction
    return tiles
#endregion
