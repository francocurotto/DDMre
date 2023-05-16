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

    # get path for movement
    var path = dungeon.get_move_path(pos_origin, pos_dest)
    if path.empty(): # case not valid path found
        print("No path to destination.")
    # case destination is not reachable (e.g. there is a monster)
    elif not tile_dest.is_reachable():
        print("Destination cannot be reached.")
    # case exceeded max movement per turn (due to ability)
    elif monster.max_move < len(path)-1:
        print("Movement exceed monster max movement per turn")
    # case missing movement crests
    elif monster.get_move_cost(path) > player.crestpool.slots["MOVEMENT"]:
        print("Not enough MOVEMENT crests.")
    # perform movement
    else: # case valid movement
        var state = perform_movement(tile_origin, tile_dest, path)
        Events.emit_signal("duel_update")
        return state
    return self

func ATTACK(cmd):
    """
    Excecute the ATTACK command.
    """
    # get data
    var pos_origin = Vector2(cmd["origin"][0], cmd["origin"][1])
    var pos_dest = Vector2(cmd["dest"][0], cmd["dest"][1])
    var ability_dict = cmd.get("ability_dict")
    var tile_origin = dungeon.get_tile(pos_origin)
    var tile_dest = dungeon.get_tile(pos_dest)
    var monster = tile_origin.content
    var target = tile_dest.content

    # check enough ATTACK crests
    if  player.crestpool.slots["ATTACK"] < monster.attack_cost:
        print("Not enough ATTACK crests.")
    # check if monster already in attack cooldown
    elif monster.attack_cooldown:
        print("Monster in attack cooldown.")
    # check valid attack
    elif not pos_dest in dungeon.get_attack_poss(pos_origin):
        print("Target out of reach.")
    # the attack is valid
    else:
        # pay the cost of attack
        player.crestpool.slots["ATTACK"] -= monster.attack_cost
        if target.is_monster():
            # activate attack ability if exists
            if ability_dict:
                monster.activate_ability(ability_dict)
            return ReplyState.new(opponent, player, dungeon, monster, target)
        elif target.is_monster_lord():
            monster.attack_monster_lord(target)
        Events.emit_signal("duel_update")
    return self

func ABILITY(cmd):
    """
    Excecute the ABILITY command.
    """
    var monster = dungeon.get_tile(cmd["pos"]).content
    var ability_dict = cmd["ability_dict"]
    for ability in monster.card.abilities:
        if ability.name == ability_dict["name"]:
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
    elif tile_dest.is_occupied():
        print("Dest tile is not a occupied")
    else: # case valid jump
        tile_dest.move_content_from(tile_origin)
        Events.emit_signal("duel_update")
    return self

func ENDTURN(_cmd):
    """
    Execute the ENDTURN command.
    """
    # reset player monster cooldowns
    for monster in player.monsters:
        monster.attack_cooldown = false
        monster.ability_cooldown = false
    # reset monster turn move count
    for monster in player.monsters:
        monster.max_move_behavior.reset_turn_move_count()
    return RollState.new(opponent, player, dungeon)

# private functions
func perform_movement(tile1, tile2, path):
    """
    Move content from tile1 to tile2 and pay movement crest.
    """
    # get monster
    var monster = tile1.content
    # check if item is activated
    var dest_content = tile2.content
    # make the movement
    tile2.move_content_from(tile1)
    monster.max_move_behavior.update_turn_move_count(len(path)-1)
    # pay the cost of the movement
    player.crestpool.slots["MOVEMENT"] -= dungeon.get_move_cost(path, monster)
    # activate item if necessary
    if dest_content.is_item():
        if dest_content.card.abilities[0].is_item_state():
            return ItemAbilityState.new(player, opponent, dungeon, dest_content, monster)
        else:
            dest_content.activate(monster)
    return self
