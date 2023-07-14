extends Node


func _ready():
    var test = "SS3M9A1D4G2"
    var regex = RegEx.new()
    regex.compile("S|[MADTG][1-9]")
    for result in regex.search_all(test):
        print(result.get_string())
