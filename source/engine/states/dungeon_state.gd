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
    var tile_origin = dungeon.get_tile(cmd["origin"])
    var tile_dest = dungeon.get_tile(cmd["dest"])
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
    var monster = dungeon.get_tile(cmd["origin"]).content
    var target = dungeon.get_tile(cmd["dest"]).content
    var ability_dict = cmd.get("ability_dict")

    # pay the cost of attack
    player.crestpool.remove_attack(monster.attack_cost)
    
    # case attack monster
    if target.is_monster():
        # activate attack ability if in command
        if ability_dict:
            var ability = monster.get_ability(ability_dict["name"])
            ability.activate(ability_dict)
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
    var monster = dungeon.get_tile(cmd["pos"]).content
    var ability_dict = cmd["ability_dict"]
    var ability = monster.get_ability(ability_dict["name"])
    
    # activate ablity
    ability.activate(ability_dict)
    monster.ability_cooldown = true
    
    Events.emit_signal("duel_update")
    return self

func JUMP(cmd):
    """
    Excecute JUMP command.
    """
    # get data
    var tile_origin = dungeon.get_tile(cmd["origin"])
    var tile_dest = dungeon.get_tile(cmd["dest"])
    
    # jump
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
