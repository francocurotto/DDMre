@tool
extends TextureRect

# export variables
@export_enum("OPEN", "BLOCK", "NEUTRAL", "PLAYER1", "PLAYER2") 
var type : String = "OPEN" :
    set(_type):
        type = _type
        self_modulate = COLORS[type]

# constants
const COLORS = {
    "OPEN"    : Color(0.3,0.3,0.3),
    "BLOCK"   : Color(0.9,0.9,0.9),
    "NEUTRAL" : Color(0.5,0.3,0.1),
    "PLAYER1" : Color(1.0,0.3,0.3),
    "PLAYER2" : Color(0.3,0.3,1.0)}
