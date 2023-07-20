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
func MOVE(cmddict):
    """
    Excecute the MOVE command.
    """
    # get data
    var tile_origin = dungeon.get_tile(cmddict["origin"])
    var tile_dest = dungeon.get_tile(cmddict["dest"])
    var monster = tile_origin.content
    var dest_content = tile_dest.content

    # perform movement
    var path = dungeon.get_move_path(monster, tile_dest)
    player.crestpool.remove_movement(dungeon.get_move_cost(path, monster))
    tile_dest.move_content_from(tile_origin)
    monster.max_move_behavior.update_turn_move_count(len(path)-1)
    
    # check for item ability effect
    if dest_content.is_item():
        # if item ability requires item ability state
        if dest_content.has_item_state_ability():
            return ItemAbilityState.new(player, opponent, dungeon, dest_content, monster)
        # if item ability activates automatically
        elif dest_content.is_item():
            dest_content.activate(monster)
    
    Events.emit_signal("duel_update")
    return self

func ATTACK(cmddict):
    """
    Excecute the ATTACK command.
    """
    # get data
    var monster = dungeon.get_tile(cmddict["origin"]).content
    var target = dungeon.get_tile(cmddict["dest"]).content
    var ability_dict = cmddict.get("ability")

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

func ABILITY(cmddict):
    """
    Excecute the ABILITY command.
    """
    # get data
    var monster = dungeon.get_tile(cmddict["pos"]).content
    var ability_dict = cmddict["ability"]
    var ability = monster.get_ability(ability_dict["name"])
    
    # activate ablity
    ability.activate(ability_dict)
    monster.ability_cooldown = true
    
    Events.emit_signal("duel_update")
    return self

func JUMP(cmddict):
    """
    Excecute JUMP command.
    """
    # get data
    var tile_origin = dungeon.get_tile(cmddict["origin"])
    var tile_dest = dungeon.get_tile(cmddict["dest"])
    
    # jump
    tile_dest.move_content_from(tile_origin)
    Events.emit_signal("duel_update")
    return self

func ENDTURN(_cmddict):
    """
    Execute the ENDTURN command.
    """
    # reset player monster cooldowns and counts
    for monster in player.monsters:
        monster.attack_cooldown_behavior.reset()
        monster.ability_cooldown = false
        monster.max_move_behavior.reset_turn_move_count()
    return RollState.new(opponent, player, dungeon)
