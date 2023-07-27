extends MarginContainer

# preloads
const DDMreEngine = preload("res://engine/engine.gd")
const Init = preload("init.gd")

# variables
var engine

func _ready():
    randomize()
    # get initialization parameters
    var init = Init.new() # needed to use super.get
    var dungpath  = init.get("DUNGPATH")
    var pool1path = init.get("POOL1PATH")
    var pool2path = init.get("POOL2PATH")
    # create engine
    engine = DDMreEngine.new(dungpath, pool1path, pool2path)
