extends "state.gd"

# constants
const NAME = "DUNGEON"

# variables
var RollState = load("engine/states/roll_state.gd")
var ReplyState = load("engine/states/reply_state.gd")
var ItemAbilityState = load("engine/states/item_ability_state.gd")

func _init(_player, _opponent, _dungeon).(_player, _opponent, _dungeon):
    pass

# public functions
func MOVE(cmd):
    """
    Excecute the MOVE command.
    """
    # get data
    var pos_origin = Vector2(cmd["origin"][0], cmd["origin"][1])
    var pos_dest = Vector2(cmd["dest"][0], cmd["dest"][1])
    var tile_origin = dungeon.get_tile(pos_origin)
    var tile_dest = dungeon.get_tile(pos_dest)
    var monster = tile_origin.content
    var dest_content = tile_dest.content

    # perform movement
    var path = dungeon.get_move_path(monster, tile_dest)
    player.crestpool.remove_movement(dungeon.get_move_cost(path, monster))
    tile_dest.move_content_from(tile_origin)
    monster.max_move_behavior.update_turn_move_count(len(path)-1)
    
    # check for item ability effect
    if dest_content.has_item_state_ability():
        return ItemAbilityState.new(player, opponent, dungeon, dest_content, monster)
    elif dest_content.is_item():
        dest_content.activate(monster)
    
    Events.emit_signal("duel_update")
    return self

func ATTACK(cmd):
    """
    Excecute the ATTACK command.
    """
    # get data
    var pos_origin = Vector2(cmd["origin"][0], cmd["origin"][1])
    var pos_dest = Vector2(cmd["dest"][0], cmd["dest"][1])
    var ability_dict = cmd.get("ability_dict")
    var monster = dungeon.get_tile(pos_origin).content
    var target = dungeon.get_tile(pos_dest).content

    # pay the cost of attack
    player.crestpool.remove_attack(monster.attack_cost)
    
    # case attack monster
    if target.is_monster():
        # activate attack ability if exists
        if ability_dict:
            monster.activate_ability(ability_dict)
        return ReplyState.new(opponent, player, dungeon, monster, target)
    
    # case attack monster lord
    elif target.is_monster_lord():
        monster.attack_monster_lord(target)
    
    Events.emit_signal("duel_update")
    return self

func ABILITY(cmd):
    """
    Excecute the ABILITY command.
    """
    # get data
    #TODO: check get tile
    var monster = dungeon.get_tile(cmd["pos"]).content
    var ability_dict = cmd["ability_dict"]
    
    # activate ablity
    var ability = monster.get_ability(ability_dict["name"])
    ability.activate(ability_dict)
    monster.ability_cooldown = true
    
    Events.emit_signal("duel_update")
    return self

func JUMP(cmd):
    """
    Excecute JUMP command.
    """
    var pos_origin = Vector2(cmd["origin"][0], cmd["origin"][1])
    var pos_dest = Vector2(cmd["dest"][0], cmd["dest"][1])
    var tile_origin = dungeon.get_tile(pos_origin)
    var tile_dest = dungeon.get_tile(pos_dest)
    
    # check origin correct
    if not tile_origin.vortex:
        print("Origin tile is not a vortex")
    elif not tile_origin.content.is_monster() or not tile_origin.content.player == player:
        print("Not appropiate monster at origin")
    # check dest correct
    elif not tile_dest.vortex:
        print("Dest tile is not a vortex")
    elif not tile_dest.is_empty():
        print("Dest tile is not a occupied")
    else: # case valid jump
        tile_dest.move_content_from(tile_origin)
        Events.emit_signal("duel_update")
    return self

func ENDTURN(_cmd):
    """
    Execute the ENDTURN command.
    """
    # reset player monster cooldowns and counts
    for monster in player.monsters:
        monster.attack_cooldown_behavior.reset()
        monster.ability_cooldown = false
        monster.max_move_behavior.reset_turn_move_count()
    return RollState.new(opponent, player, dungeon)
