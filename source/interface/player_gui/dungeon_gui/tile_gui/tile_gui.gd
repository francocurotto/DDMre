@tool
extends TextureRect

# export variables
@export_enum("OPEN", "BLOCK", "NEUTRAL", "PLAYER") 
var tile_type : String = "OPEN" :
    set(_tile_type):
        tile_type = _tile_type
        set_tile_icon()

@export_range(1, 2) var tile_player = 1 :
    set(_tile_player):
        tile_player = _tile_player
        set_tile_icon()

func set_tile_icon():
    if tile_type == "PLAYER":
        self_modulate = COLORS[tile_type+str(tile_player)]
    else:
        self_modulate = COLORS[tile_type]

@export_enum("NONE", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM")
var dungobj_type : String = "NONE" :
    set(_dungobj_type):
        dungobj_type = _dungobj_type
        set_dungobj_icon()

@export_range(1, 2) var dungobj_player = 1 :
    set(_dungobj_player):
        dungobj_player = _dungobj_player
        set_dungobj_icon()

func set_dungobj_icon():
    if dungobj_type == "NONE":
        $DungobjGui.texture = null
    elif dungobj_type == "MONSTER_LORD":
        $DungobjGui.texture = load("res://assets/icons/MONSTER_LORD.svg")
    else:
        var dungobj_icon = "SUMMON_" + dungobj_type + "_" + str(dungobj_player)
        $DungobjGui.texture = load("res://assets/icons/%s.svg" % dungobj_icon)
       
# constants
const COLORS = {
    "OPEN"    : Color(0.3,0.3,0.3),
    "BLOCK"   : Color(0.9,0.9,0.9),
    "NEUTRAL" : Color(0.5,0.3,0.1),
    "PLAYER1" : Color(0.3,0.3,1.0),
    "PLAYER2" : Color(1.0,0.3,0.3)}
