extends "ability.gd"

# variables
var monster
var negate_count = 0

func _init(ability_dict).(ability_dict):
    pass

# public functions
func initialize(_monster, _dungeon):
    .initialize(_monster, _dungeon)
    monster = _monster
    enable()

func negate():
    """
    When ability is negated by other effect, increase negate count.
    If it is first negate, disable ability.
    """
    negate_count += 1
    if negate_count == 1:
        disable()

func remove_negate():
    """
    When negation on ability is removed, reduce negate count.
    If last negate, reenable ability.
    """
    negate_count -= 1
    if negate_count == 0:
        enable()

func get_monsters_tiles():
    var select_tiles = []
    for monster in dungeon.monsters:
        select_tiles.append(monster.tile)
    return select_tile

func get_player_other_monsters_tiles():
    var select_tiles = []
    for tile in dungeon.tiles:
        var dungobj = tile.content
        if dungobj.is_monster() and dungobj != monster and dungobj.player == monster.player:
            select_tiles.append(tile)
    return select_tiles

func get_opponent_monsters_tiles():
    var select_tiles = []
    for tile in dungeon.tiles:
        var dungobj = tile.content
        if dungobj.is_monster() and dungobj.player != monster.player:
            select_tiles.append(tile)
    return select_tiles    

func get_opponent_summons_tiles():
    var select_tiles = []
    for tile in dungeon.tiles:
        var dungobj = tile.content
        if dungobj.is_summon() and dungobj.player != monster.player:
            select_tiles.append(tile)
    return select_tiles   

func get_block_tiles():
    var select_tiles = []
    for tile in dungeon.tiles:
        if tile.is_block():
            select_tiles.append(tile)
    return select_tiles

func get_tiles_in_range(tile_range):
    """
    Return a list of tiles at range tile_range from ability monster position
    (excluding monster own position).
    """
    var init_pos = monster.tile.pos
    var range_tiles = []
    for tile in dungeon.tiles:
        var range_dist = abs(tile.pos.x-init_pos.x) + abs(tile.pos.y-init_pos.y)
        if range_dist>0 and  range_dist<=tile_range:
            if tile.is_path():
                range_tiles.append(tile)
    return range_tiles

# is functions
func is_negated():
    return negate_count > 0

