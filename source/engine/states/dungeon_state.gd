extends "state.gd"
## Dungeon State.
##
## State where the player can control its monsters in the dungoen. This 
## includes moving and attacking and casting abilities.

# constants
const NAME = "DUNGEON"

# variables
var RollState = load("engine/states/roll_state.gd")
var ReplyState = load("engine/states/reply_state.gd")
var ItemAbilityState = load("engine/states/item_ability_state.gd")

func _init(_player, _opponent, _dungeon):
    super(_player, _opponent, _dungeon)

# public functions
## Excecute the MOVE command. Move a player monster from one tile to another. 
## If an item that requires manual activation is reached, go to Item Ability
## State.
func MOVE(cmddict):
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
        if dest_content.has_item_manual_ability():
            return ItemAbilityState.new(player, opponent, dungeon, dest_content, monster)
        # if item ability activates automatically
        else:
            dest_content.activate(monster)
            
    # return same state
    return self

## Excecute the ATTACK command. Attack an opponent monster or monster lord with 
## a player monster. If target is a monster go to Reply State from the side of 
## opponent.
func ATTACK(cmddict):
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
        # return opponent reply state
        return ReplyState.new(opponent, player, dungeon, monster, target)
    # case attack monster lord
    elif target.is_monster_lord():
        monster.attack_monster_lord(target)
        
    # return same state
    return self

## Excecute the CAST command. Cast the standing ability of a player monster.
func CAST(cmddict):
    # get data
    var monster = dungeon.get_tile(cmddict["pos"]).content
    var ability_dict = cmddict["ability"]
    var ability = monster.get_ability(ability_dict["name"])
    
    # cast ablity
    ability.activate(ability_dict)
    monster.ability_cooldown = true
    
    # return same state
    return self

## Excecute the JUMP command. Move a player monster located in a tile with a 
## vortex to another tile with a vortex.
func JUMP(cmddict):
    # get data
    var tile_origin = dungeon.get_tile(cmddict["origin"])
    var tile_dest = dungeon.get_tile(cmddict["dest"])
    
    # jump
    tile_dest.move_content_from(tile_origin)
    
    # return same state
    return self

## Excecute the ENDTURN command. End player player turn and start the opponent 
## turn.
func ENDTURN(_cmddict):
    # reset player monster cooldowns and counts
    for monster in player.monsters:
        monster.attack_cooldown_behavior.reset()
        monster.ability_cooldown = false
        monster.max_move_behavior.reset_turn_move_count()
    
    # return new opponent state
    return RollState.new(opponent, player, dungeon)
