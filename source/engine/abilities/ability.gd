extends Reference

# variables
var name
var summon
var dungeon

func _init(ability_info):
    name = ability_info["NAME"]

# public functions
func initialize(_summon, _dungeon):
    summon = _summon
    dungeon = _dungeon

func deactivate():
    pass

func pay_crests(crest, amount):
    summon.player.crestpool.remove_crests(crest, amount)

func gain_crests(crest, amount):
    summon.player.crestpool.add_crests(crest, amount)

# is functions
func activates_on_dim():
    return false

func is_standing():
    return false

func is_manual_dim():
    return false

func is_manual_item():
    return false

func is_negated():
    return false

# private functions
func get_monsters_tiles():
    #GODOT4: use array map
    var select_tiles = []
    for dungeon_monster in dungeon.monsters:
        select_tiles.append(dungeon_monster.tile)
    return select_tiles

func get_player_other_monsters_tiles():
    #GODOT4: use array filter
    var select_tiles = []
    for tile in dungeon.tiles:
        var dungobj = tile.content
        if dungobj.is_monster() and dungobj != summon and dungobj.player == summon.player:
            select_tiles.append(tile)
    return select_tiles

func get_opponent_monsters_tiles():
    #GODOT4: use array filter
    var select_tiles = []
    for tile in dungeon.tiles:
        var dungobj = tile.content
        if dungobj.is_monster() and dungobj.player != summon.player:
            select_tiles.append(tile)
    return select_tiles    

func get_opponent_summons_tiles():
    #GODOT4: use array filter
    var select_tiles = []
    for tile in dungeon.tiles:
        var dungobj = tile.content
        if dungobj.is_summon() and dungobj.player != summon.player:
            select_tiles.append(tile)
    return select_tiles   

func get_block_tiles():
    #GODOT4: use array filter
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
    var init_pos = summon.tile.pos
    var range_tiles = []
    for tile in dungeon.tiles:
        var range_dist = abs(tile.pos.x-init_pos.x) + abs(tile.pos.y-init_pos.y)
        if range_dist>0 and  range_dist<=tile_range:
            if tile.is_path():
                range_tiles.append(tile)
    return range_tiles
