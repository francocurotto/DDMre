tool
extends Node

# filepath
const LIBPATH = "res://LIBRARY.json"
const DUNGPATH = "res://dungeons/test2.json"
const POOL1PATH = "res://dicepools/test1.json"
const POOL2PATH = "res://dicepools/test2.json"

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
const NetX1 = preload("res://engine/dungeon/nets/net_x1.gd")
func create_net(netname):
    match netname:
        "X1" : return NetX1.new()
