extends MarginContainer

# preloads
const DDMreEngine = preload("res://engine/engine.gd")
const Init = preload("init.gd")

# variables
var engine

# onready variables
@onready var p1gui = $P1GUI
@onready var p2gui = $P2GUI

func _ready():
    randomize()
    # get initialization parameters
    var init = Init.new() # needed to use get()
    var dungpath  = init.get("DUNGPATH")
    var pool1path = init.get("POOL1PATH")
    var pool2path = init.get("POOL2PATH")
    # create engine
    engine = DDMreEngine.new(dungpath, pool1path, pool2path)
    # set player guis
    p1gui.initialize(engine, engine.player1, engine.player2)    
    p2gui.initialize(engine, engine.player2, engine.player1)
