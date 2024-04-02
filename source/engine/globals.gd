@tool
extends Node
## Autoload with global variables and functions.
##
## Autoload that holds variables and functions used across the game, in 
## particular, that are needed for both the DDMre engine and the interface.

#region filepaths
## Path to the JSON file that has the dice information.
const LIBPATH  = "res://databases/LIBRARY.json"
## Path to the JSON file that has the abilities information.
const ABIPATH  = "res://databases/ABILITIES.json"
## Path to the JSON file that has the default dungeon layout.
const DUNGPATH = "res://databases/dungeons/default.json"
#endregion

#region constants
const DUNGEON_HEIGHT = 19 ## Number of verical tiles of dungeon. 
const DUNGEON_WIDTH  = 13 ## Number of horizontal tiles of dungeon.
const DICEPOOL_SIZE  = 15 ## Number of dice in player dicepool.
#endregion

#region variables
## Dictionary with the abilities information. Used when an ability description 
## needs to be displayed.
var ABIDICT = read_jsonfile(ABIPATH)
#endregion

#region functions
## Read a JSON file and convert it to a dictionary.
func read_jsonfile(filepath):
    """
    Read json file and return it as a dictionary.
    """
    var jsonstr = FileAccess.get_file_as_string(filepath)
    var jsondict = JSON.parse_string(jsonstr)
    return jsondict
#endregion
