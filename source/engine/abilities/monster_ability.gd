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
            
# is functions
func is_negated():
    return negate_count > 0

