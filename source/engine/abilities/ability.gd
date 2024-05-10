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
var negated : get = is_negated ## True if ability is negated
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

## Make player owner of summon that has ability to pay [param amount] number
## of crests of type [param crest] from its crestpool. Used to pay for ability
## activation.
func pay_crests(crest, amount):
    summon.player.crestpool.remove_crests(crest, amount)

## Make player ower of summon that has ability to gain [param amount] number
## of crests of type [param crest] in its crestpool. Used as the effect of 
## some abilities.
func gain_crests(crest, amount):
    summon.player.crestpool.add_crests(crest, amount)
#endregion

#region is functions
## By default, ability is not negated.
func is_negated():
    return false
#endregion

# private functions
## Get an array of tiles from dungeon where monsters are located.
func get_monsters_tiles():
    var tiles = dungeon.monsters.map(func(monster): return monster.tile)
    return tiles

## Get an array of tiles from dungeon where player monsters different from
## ability monster are located.
func get_player_other_monsters_tiles():
    # get tiles with player summons
    var tiles = summon.player.monsters.map(func(monster): return monster.tile)
    # filter tiles with summon different from ability summon
    tiles = tiles.filter(func(tile): return tile.content != summon)
    return tiles

## Get an array of tiles from dungeon where opponent monsters are located.
func get_opponent_monsters_tiles():
    var opponent = summon.player.opponent
    var tiles = opponent.monsters.map(func(monster): return monster.tile)
    return tiles    

## Get an array of tiles from dungeon where opponent summons are located.
func get_opponent_summons_tiles():
    var opponent = summon.player.opponent
    var tiles = dungeon.summons.map(func(_summon): return _summon.tile)
    tiles = tiles.filter(func(tile): return tile.content.player == opponent)
    return tiles   

## Get an array of tiles from dungeon where block tiles are located.
func get_block_tiles():
    var tiles = dungeon.tiles.map(func(tile): return tile.is_block())
    return tiles

## Get an array of tiles from dungeon where monsters with active ability with
## name [param ability] is located.
func get_active_ability_monsters_tiles(ability):
    var tiles = dungeon.monsters.map(func(monster): return monster.tile)
    tiles = tiles.filter(func(tile): tile.content.has_active_ability(ability))
    return tiles

## Get an array of tiles from dungeon where the monsters with the lowest
## attacks are located.
func get_weakest_monsters_tiles():
    var tiles = []
    for monster in dungeon.monsters:
        if monster != summon:
            if tiles.is_empty():
                tiles.append(monster.tile)
            elif tiles[0].content.attack == monster.attack:
                tiles.append(monster.tile)
            elif tiles[0].content.attack > monster.attack:
                tiles = [monster.tile]
    return tiles

## Get an array of tiles from dungeon where opponent summons are located that
## are at a range [param tile_range] from tile where summon with ability is
## located.
func get_range_opponent_summon_tiles(tile_range):
    var tiles = []
    for tile in get_opponent_summons_tiles():
        if tile.tile_range(summon.tile) <= tile_range:
            tiles.append(tile)
    return tiles

## Get an array of tiles that are at a range [param tile_range] from tile where
## summon with ability is located.
func get_tiles_in_range(tile_range):
    var tiles = []
    for tile in dungeon.tiles:
        if tile.tile_range(summon.tile) <= tile_range:
            tiles.append(tile)
    return tiles
