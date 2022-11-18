tool
extends AspectRatioContainer

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
    $Icon.texture = load("res://art/icons/CREST_" + crest  + ".png")
    if has_node("Icon"):
        position_mult()

func set_mult(_mult):
    mult = _mult
    if has_node("Icon"):
        $Icon/Mult.text = str(mult)

# private functions
func position_mult():
    if crest == "SUMMON":
        position_mult_center()
    else:
        position_mult_corner()

func position_mult_center():
    $Icon/Mult.anchor_left = 0.5
    $Icon/Mult.anchor_right = 0.5
    $Icon/Mult.anchor_top = 0.5
    $Icon/Mult.anchor_bottom = 0.5
    var multsize = $Icon/Mult.get_size()
    $Icon/Mult.margin_left = -multsize.x/2
    $Icon/Mult.margin_right = -multsize.x/2
    $Icon/Mult.margin_top =  -multsize.y/2
    $Icon/Mult.margin_bottom = -multsize.y/2

func position_mult_corner():
    $Icon/Mult.anchor_left = 1
    $Icon/Mult.anchor_right = 1
    $Icon/Mult.anchor_top = 1
    $Icon/Mult.anchor_bottom = 1
    var multsize = $Icon/Mult.get_size()
    $Icon/Mult.margin_left = -multsize.x
    $Icon/Mult.margin_top =  -multsize.y
