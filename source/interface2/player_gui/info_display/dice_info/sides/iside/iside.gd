tool
extends TextureRect

# export variables
export (String, "SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP") var crest = "MOVEMENT" setget set_crest
export (int, 1, 9) var mult = 1 setget set_mult

func _ready():
    position_mult()

# setget functions
func set_side(side):
    set_crest(side.crest.NAME)
    set_mult(side.mult)

func set_crest(_crest):
    crest = _crest
    texture = load("res://art/icons/CREST_" + crest  + ".png")
    if has_node("Mult"):
        position_mult()

func set_mult(_mult):
    mult = _mult
    if has_node("Mult"):
        $Mult.text = str(mult)

# private functions
func position_mult():
    if crest == "SUMMON":
        position_mult_center()
    else:
        position_mult_corner()

func position_mult_center():
    $Mult.anchor_left = 0.5
    $Mult.anchor_right = 0.5
    $Mult.anchor_top = 0.5
    $Mult.anchor_bottom = 0.5
    var multsize = $Mult.get_size()
    $Mult.margin_left = -multsize.x/2
    $Mult.margin_right = -multsize.x/2
    $Mult.margin_top =  -multsize.y/2
    $Mult.margin_bottom = -multsize.y/2

func position_mult_corner():
    $Mult.anchor_left = 1 
    $Mult.anchor_right = 1
    $Mult.anchor_top = 1
    $Mult.anchor_bottom = 1
    var multsize = $Mult.get_size()
    $Mult.margin_left = -multsize.x
    $Mult.margin_top =  -multsize.y
