extends Node

#region enums
enum GUISTATE {
	ROLL,
	DIMENSION,
	DUNGEON
}

enum LAYERS {
	ALL = 1,
	DICE = 2,
	TILES = 4
}
#endregion

#region constants
## Path to the JSON file that has the dice information.
const LIBPATH  = "res://databases/LIBRARY.json"
const DUNGEON_HEIGHT = 19 ## Number of verical tiles of dungeon. 
const DUNGEON_WIDTH  = 13 ## Number of horizontal tiles of dungeon.
const DICEPOOL_SIZE  = 15 ## Number of dice in player dicepool.
const MAX_CRESTS     = 99 ## Maximum number of crests for each crest type
const MAX_HEARTS     = 3  ## Maximum number of hearts per player
const PATH_TILE_HEIGHT = 0.052 ## Height where path tile is located in dungeon
const DICE_SIZE = 1.0 ## Dice size in every direction
const SUMMON_COLORS = {
	"DRAGON"      : Color(1.0, 0.0, 0.0),
	"SPELLCASTER" : Color(1.0, 1.0, 1.0),
	"UNDEAD"      : Color(1.0, 1.0, 0.0),
	"BEAST"       : Color(0.0, 1.0, 0.0),
	"WARRIOR"     : Color(0.0, 0.0, 1.0),
	"ITEM"        : Color(0.2, 0.2, 0.2)
}
#endregion

#region public variables
var dungeon
var duel_camera
#endregion

#region public functions
## Read a JSON file and convert it to a dictionary.
func read_jsonfile(filepath):
	var jsonstr = FileAccess.get_file_as_string(filepath)
	var jsondict = JSON.parse_string(jsonstr)
	return jsondict
#endregion
