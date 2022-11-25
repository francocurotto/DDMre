tool
extends Node

# filepath
const LIBPATH = "res://LIBRARY.json"
#const DUNGPATH = "res://dungeons/default.json"
const DUNGPATH = "res://dungeons/test2.json"
#const RANDOMPOOL = true
const RANDOMPOOL = false
const POOL1PATH = "res://dicepools/test1.json"
const POOL2PATH = "res://dicepools/test1.json"

# arrays, dictionaries
const CRESTS = ["SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP"]
const CRESTCHARS = ["S", "M", "A", "D", "G", "T"]
const TYPES = ["DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR"]

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
