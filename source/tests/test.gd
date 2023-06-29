extends Node

func _ready():
    print(typeof({"a":2}))
    print(typeof({"a":2})==TYPE_DICTIONARY)
    call("test")

func test():
    print("test")
