extends Node

func _ready():
    print(typeof({"a":2}))
    print(typeof({"a":2})==TYPE_DICTIONARY)
