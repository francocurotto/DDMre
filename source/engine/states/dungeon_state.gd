extends "state.gd"

# constants
const NAME = "DUNGEON"

# variables
var RollState = load("engine/states/roll_state.gd")

func _init(_player, _opponent, _dungeon).(_player, _opponent, _dungeon):
    cmdlist += ["MOVE", "ENDTURN"]
    # reset player monster cooldown
    for monster in player.monsters:
        monster.cooldown = false

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
    
    # get path for movement
    var path = dungeon.get_movepath(pos_origin, pos_dest)
    if path.empty(): # case not valid path found
        print("Destination cannot be reached.")
    # case missing movement crests
    elif len(path)-1 > player.crestpool.slots["MOVEMENT"]:
        print("Not enough MOVEMENT crests.")
    # perform movement
    else: # case valid movement
        perform_movement(tile_origin, tile_dest, path, cmd["name"])
    return self

func ATTACK(cmd):
    """
    Excecute the ATTACK command.
    """
    # get data
    var pos_origin = Vector2(cmd["origin"][0], cmd["origin"][1])
    var pos_dest = Vector2(cmd["dest"][0], cmd["dest"][1])
    var tile_origin = dungeon.get_tile(pos_origin)
    var tile_dest = dungeon.get_tile(pos_dest)

    # check valid attack
    if not pos_dest in dungeon.get_attackposs(player, pos_origin):
        print("Target out of reach.")
    # check enough ATTACK crests
    elif  player.crestpool.slots["ATTACK"] < 1:
        print("Not enough ATTACK crests.")
    elif tile_origin.content.cooldown:
        print("Monster in cooldown.")
    # perform attack
    else:
        perform_attack(tile_origin, tile_dest, cmd["name"])
    return self
    
func ENDTURN(_cmd):
    """
    Execute the ENDTURN command.
    """
    return RollState.new(opponent, player, dungeon)

# private functions
func perform_movement(tile1, tile2, path, cmdname):
    """
    Move content from tile1 to tile2 and pay movement crest.
    """
    tile2.content = tile1.content
    tile1.empty_tile()
    # pay the cost of the movement
    player.crestpool.slots["MOVEMENT"] -= len(path)-1
    # emit duel update signal
    emit_signal("duel_update", cmdname)

func perform_attack(tile1, tile2, cmdname):
    """
    Perform attack from tile1 to tile2 and pay attack crest.
    """
    var monster = tile1.content
    var target = tile2.content
    if target.is_monster():
        monster.attack_monster(target, false)
    elif target.is_monster_lord():
        monster.attack_monster_lord(target)
    # pay the cost of attack
    player.crestpool.slots["ATTACK"] -= 1
    emit_signal("duel_update", cmdname)
    
