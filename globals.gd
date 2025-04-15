extends Node

#region functions
## Read a JSON file and convert it to a dictionary.
func read_jsonfile(filepath):
	var jsonstr = FileAccess.get_file_as_string(filepath)
	var jsondict = JSON.parse_string(jsonstr)
	return jsondict
#endregion
