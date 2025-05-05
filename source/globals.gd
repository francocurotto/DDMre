extends Node

#region constants
## Path to the JSON file that has the dice information.
const LIBPATH  = "res://databases/LIBRARY.json"
const TYPECOLORS = {
	"DRAGON"      : Color(1.0, 0.0, 0.0),
	"SPELLCASTER" : Color(1.0, 1.0, 1.0),
	"UNDEAD"      : Color(1.0, 1.0, 0.0),
	"BEAST"       : Color(0.0, 1.0, 0.0),
	"WARRIOR"     : Color(0.0, 0.0, 1.0),
	"ITEM"        : Color(0.2, 0.2, 0.2)
}
#endregion

#region public functions
## Read a JSON file and convert it to a dictionary.
func read_jsonfile(filepath):
	var jsonstr = FileAccess.get_file_as_string(filepath)
	var jsondict = JSON.parse_string(jsonstr)
	return jsondict
#endregion
