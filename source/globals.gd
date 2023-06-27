tool
extends Node

# filepath
const LIBPATH = "res://databases/LIBRARY.json"
const ABIPATH = "res://databases/ABILITIES.json"

# values
const DUNGEON_HEIGHT = 19
const DUNGEON_WIDTH = 13

# arrays, dictionaries
const MONSTERTYPES = ["DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR"]
const SUMMONTYPES  = ["DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM"]
const CRESTTYPES = ["SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP"]
const CRESTICONS = {"SUMMON":"★", "MOVEMENT":"⬆", "ATTACK":"⚔", "DEFENSE":"⛨", "MAGIC":"✡", "TRAP":"⚡"}
var ABIDICT = read_jsonfile(ABIPATH)

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
