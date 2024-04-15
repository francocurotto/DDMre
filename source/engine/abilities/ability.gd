extends RefCounted
## Special property of some summons that can affects entities in the dungeon.
##
## Abilities are special properties of some summons that have effect in its
## summon, other summons or the dungeon itself. The way the ability is
## manifested in the duel depends on the specific type of ability.

#region variables
var ability_info ## Dictionary with the infi to define and use the ability
var name         ## Unique name of the ability
var summon       ## Summon owner of the ability
var dungeon      ## Reference of dungeon in the duel
#endregion

#region builtin functions
func _init(_ability_info):
    ability_info = _ability_info
    name = ability_info["NAME"]
#endregion

#region public functions
## Setup abilities attributes [param _summon] and [param dungeon] once its
## assigned summon is summoned.
func setup(_summon, _dungeon):
    summon = _summon
    dungeon = _dungeon

## By default, abilities cannot be deactivated.
func deactivate():
    pass

## By default, abilities cannot be negated.
func negate():
    pass

func pay_crests(crest, amount):
    summon.player.crestpool.remove_crests(crest, amount)

func gain_crests(crest, amount):
    summon.player.crestpool.add_crests(crest, amount)
#endregion

# is functions
func activates_on_dim():
    return false

func is_cast():
    return false

func is_dim_manual():
    return false

func is_item_manual():
    return false

func is_negated():
    return false

# private functions
func get_monsters_tiles():
    #GODOT4: use array map
    var select_tiles = []
    for monster in dungeon.monsters:
        select_tiles.append(monster.tile)
    return select_tiles

func get_player_other_monsters_tiles():
    #GODOT4: use array filter
    var select_tiles = []
    for monster in summon.player.monsters:
        if monster != summon:
            select_tiles.append(monster.tile)
    return select_tiles

func get_opponent_monsters_tiles():
    #GODOT4: use array map
    var select_tiles = []
    for monster in summon.player.opponent.monsters:
        select_tiles.append(monster.tile)
    return select_tiles    

func get_opponent_summons_tiles():
    #GODOT4: use array filter
    var select_tiles = []
    for _summon in dungeon.summons:
        if _summon.player != summon.player:
            select_tiles.append(_summon.tile)
    return select_tiles   

func get_block_tiles():
    #GODOT4: use array filter
    var select_tiles = []
    for tile in dungeon.tiles:
        if tile.is_block():
            select_tiles.append(tile)
    return select_tiles

func get_active_ability_monsters_tiles(ability):
    #GODOT4: use array filter
    var select_tiles = []
    for monster in dungeon.monsters:
        if monster.has_active_ability(ability):
            select_tiles.append(monster.tile)
    return select_tiles

func get_weakest_monsters_tiles():
    var select_tiles = []
    for monster in dungeon.monsters:
        if monster != summon:
            if select_tiles.is_empty():
                select_tiles.append(monster.tile)
            elif select_tiles[0].content.attack == monster.attack:
                select_tiles.append(monster.tile)
            elif select_tiles[0].content.attack > monster.attack:
                select_tiles = [monster.tile]
    return select_tiles

func get_range_opponent_summon_tiles(tile_range):
    var select_tiles = []
    for tile in get_opponent_summons_tiles():
        if tile.tile_range(summon.tile) <= tile_range:
            select_tiles.append(tile)
    return select_tiles

func get_tiles_in_range(tile_range):
    """
    Return a list of tiles at range tile_range from ability monster position
    (excluding monster own position).
    """
    #GODOT4: use array filter
    var range_tiles = []
    for tile in dungeon.tiles:
        if tile.tile_range(summon.tile) <= tile_range:
            range_tiles.append(tile)
    return range_tiles
