extends Node

#region filepaths
## Path to the JSON file that has the dice information.
const LIBPATH  = "res://databases/LIBRARY.json"
#endregion

#region functions
## Read a JSON file and convert it to a dictionary.
func read_jsonfile(filepath):
	var jsonstr = FileAccess.get_file_as_string(filepath)
	var jsondict = JSON.parse_string(jsonstr)
	return jsondict
#endregion
