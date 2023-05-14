tool
extends Node

# filepath
const LIBPATH = "res://LIBRARY.json"
#const DUNGPATH = "res://dungeons/default.json"
#const DUNGPATH = "res://dungeons/test_pass.json"
#const DUNGPATH = "res://dungeons/test_target.json"
#const DUNGPATH = "res://dungeons/test_power.json"
#const DUNGPATH = "res://dungeons/test_move.json"
#const DUNGPATH = "res://dungeons/test_items.json"
#const DUNGPATH = "res://dungeons/test_dim_abilities.json"
#const DUNGPATH = "res://dungeons/test_dim_buff_dead_type.json"
#const DUNGPATH = "res://dungeons/test_exodia.json"
#const DUNGPATH = "res://dungeons/test_stops.json"
#const DUNGPATH = "res://dungeons/test_protect_type.json"
#const DUNGPATH = "res://dungeons/test_turn_slow_type.json"
#const DUNGPATH = "res://dungeons/test_raise_attack.json"
#const DUNGPATH = "res://dungeons/test_reduce_damage.json"
#const DUNGPATH = "res://dungeons/test_reply_abilities.json"
#const DUNGPATH = "res://dungeons/test_buff_self.json"
#const DUNGPATH = "res://dungeons/test_buff_damage.json"
#const DUNGPATH = "res://dungeons/test_distance_attack.json"
#const DUNGPATH = "res://dungeons/test_range_kill_all.json"
#const DUNGPATH = "res://dungeons/test_trade_health.json"
#const DUNGPATH = "res://dungeons/test_steal_monster.json"
#const DUNGPATH = "res://dungeons/test_mind_control.json"
#const DUNGPATH = "res://dungeons/test_kill_block.json"
#const DUNGPATH = "res://dungeons/test_range_level_kill.json"
#const DUNGPATH = "res://dungeons/test_roll_level_kill.json"
#const DUNGPATH = "res://dungeons/test_dim_kill_tunnel_all.json"
const DUNGPATH = "res://dungeons/test_dim_trade_crest.json"
#const DUNGPATH = "res://dungeons/test_dim_kill_tunnel.json"
#const DUNGPATH = "res://dungeons/test_dim_kill_weakest.json"
#const DUNGPATH = "res://dungeons/test_monster_reborn.json"
#const RANDOMPOOL = true
const RANDOMPOOL = false
#const POOL1PATH = "res://dicepools/test_pass.json";const POOL2PATH = "res://dicepools/test_pass.json"
#const POOL1PATH = "res://dicepools/test_target.json";const POOL2PATH = "res://dicepools/test_target.json"
#const POOL1PATH = "res://dicepools/test_power.json";const POOL2PATH = "res://dicepools/test_power.json"
#const POOL1PATH = "res://dicepools/test_move.json";const POOL2PATH = "res://dicepools/test_move.json"
#const POOL1PATH = "res://dicepools/test_items.json";const POOL2PATH = "res://dicepools/test_items.json"
#const POOL1PATH = "res://dicepools/test_dim_abilities.json";const POOL2PATH = "res://dicepools/test_dim_abilities.json"
#const POOL1PATH = "res://dicepools/test_dim_buff_dead_type.json";const POOL2PATH = "res://dicepools/test_dim_buff_dead_type.json"
#const POOL1PATH = "res://dicepools/test_exodia.json";const POOL2PATH = "res://dicepools/test_exodia.json"
#const POOL1PATH = "res://dicepools/test_bufftype.json";const POOL2PATH = "res://dicepools/test_bufftype.json"
#const POOL1PATH = "res://dicepools/test_stops.json";const POOL2PATH = "res://dicepools/test_stops.json"
#const POOL1PATH = "res://dicepools/test_protect_type.json";const POOL2PATH = "res://dicepools/test_protect_type.json"
#const POOL1PATH = "res://dicepools/test_turn_slow_type.json";const POOL2PATH = "res://dicepools/test_turn_slow_type.json"
#const POOL1PATH = "res://dicepools/test_vortex.json";const POOL2PATH = "res://dicepools/test_vortex.json"
#const POOL1PATH = "res://dicepools/test_raise_attack.json";const POOL2PATH = "res://dicepools/test_raise_attack.json"
#const POOL1PATH = "res://dicepools/test_reduce_damage.json";const POOL2PATH = "res://dicepools/test_reduce_damage.json"
#const POOL1PATH = "res://dicepools/test_reply_abilities.json";const POOL2PATH = "res://dicepools/test_reply_abilities.json"
#const POOL1PATH = "res://dicepools/test_buff_self.json";const POOL2PATH = "res://dicepools/test_buff_self.json"
#const POOL1PATH = "res://dicepools/test_buff_damage.json";const POOL2PATH = "res://dicepools/test_buff_damage.json"
#const POOL1PATH = "res://dicepools/test_distance_attack.json";const POOL2PATH = "res://dicepools/test_distance_attack.json"
#const POOL1PATH = "res://dicepools/test_range_kill_all.json";const POOL2PATH = "res://dicepools/test_range_kill_all.json"
#const POOL1PATH = "res://dicepools/test_trade_health.json";const POOL2PATH = "res://dicepools/test_trade_health.json"
#const POOL1PATH = "res://dicepools/test_steal_monster.json";const POOL2PATH = "res://dicepools/test_steal_monster.json"
#const POOL1PATH = "res://dicepools/test_mind_control.json";const POOL2PATH = "res://dicepools/test_mind_control.json"
#const POOL1PATH = "res://dicepools/test_kill_block.json";const POOL2PATH = "res://dicepools/test_kill_block.json"
#const POOL1PATH = "res://dicepools/test_range_level_kill.json";const POOL2PATH = "res://dicepools/test_range_level_kill.json"
#const POOL1PATH = "res://dicepools/test_roll_level_kill.json";const POOL2PATH = "res://dicepools/test_roll_level_kill.json"
#const POOL1PATH = "res://dicepools/test_dim_kill_tunnel_all.json";const POOL2PATH = "res://dicepools/test_dim_kill_tunnel_all.json"
const POOL1PATH = "res://dicepools/test_dim_trade_crest.json";const POOL2PATH = "res://dicepools/test_dim_trade_crest.json"
#const POOL1PATH = "res://dicepools/test_dim_kill_tunnel.json";const POOL2PATH = "res://dicepools/test_dim_kill_tunnel.json"
#const POOL1PATH = "res://dicepools/test_dim_kill_weakest.json";const POOL2PATH = "res://dicepools/test_dim_kill_weakest.json"
#const POOL1PATH = "res://dicepools/test_monster_reborn.json";const POOL2PATH = "res://dicepools/test_monster_reborn.json"

# arrays, dictionaries
const CRESTS = ["SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP"]
const CRESTCHARS = ["S", "M", "A", "D", "G", "T"]
const TYPES = ["DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR"]
const CRESTICONS = {"SUMMON":"★", "MOVEMENT":"⬆", "ATTACK":"⚔", "DEFENSE":"⛨", "MAGIC":"✡", "TRAP":"⚡"}

# IO functions
func read_jsonfile(filepath):
    """
    Read json file and return it as a dictionary.
    """
    var file = File.new()
    file.open(filepath, File.READ)
    var jsondict = parse_json(file.get_as_text())
    file.close()
    return jsondict

# conversion functions
func str2pos(string):
    """
    Convert string type positioning to vector type.
    """
    return Vector2(ord(string[0])-97, int(string.substr(1))-1)

func to_engineidx(engineidx):
    """
    Convert from interface dice indexing to engine dice indexing.
    """
    return engineidx-1

# net functions
const NetT1 = preload("res://engine/dungeon/nets/net_t1.gd")
const NetT2 = preload("res://engine/dungeon/nets/net_t2.gd")
const NetZ1 = preload("res://engine/dungeon/nets/net_z1.gd")
const NetZ2 = preload("res://engine/dungeon/nets/net_z2.gd")
const NetX1 = preload("res://engine/dungeon/nets/net_x1.gd")
const NetX2 = preload("res://engine/dungeon/nets/net_x2.gd")
const NetM1 = preload("res://engine/dungeon/nets/net_m1.gd")
const NetM2 = preload("res://engine/dungeon/nets/net_m2.gd")
const NetS1 = preload("res://engine/dungeon/nets/net_s1.gd")
const NetS2 = preload("res://engine/dungeon/nets/net_s2.gd")
const NetL1 = preload("res://engine/dungeon/nets/net_l1.gd")
func create_net(netname):
    match netname:
        "T1" : return NetT1.new()
        "T2" : return NetT2.new()
        "Z1" : return NetZ1.new()
        "Z2" : return NetZ2.new()
        "X1" : return NetX1.new()
        "X2" : return NetX2.new()
        "M1" : return NetM1.new()
        "M2" : return NetM2.new()
        "S1" : return NetS1.new()
        "S2" : return NetS2.new()
        "L1" : return NetL1.new()
