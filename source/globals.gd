@tool
extends Node

# filepath
const LIBPATH  = "res://databases/LIBRARY.json"
const ABIPATH  = "res://databases/ABILITIES.json"
const DUNGPATH = "res://databases/dungeons/default.json"

# values
const DUNGEON_HEIGHT = 19
const DUNGEON_WIDTH = 13
const DICEPOOL_SIZE = 15

# arrays, dictionaries
var ABIDICT = read_jsonfile(ABIPATH)

# IO functions
func read_jsonfile(filepath):
    """
    Read json file and return it as a dictionary.
    """
    var jsonstr = FileAccess.get_file_as_string(filepath)
    var jsondict = JSON.parse_string(jsonstr)
    return jsondict
