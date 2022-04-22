tool
extends TextureRect

export (String, "SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP") var crest = "MOVEMENT" setget set_crest
export (int, 1, 9) var mult = 1 setget set_mult

func _ready():
    position_mult()

func set_side(side):
    set_crest(side.crest.NAME)
    set_mult(side.mult)

func set_crest(_crest):
    crest = _crest
    texture = load("res://art/icons/CREST_" + crest  + ".png")
    $Mult.visible = crest != "SUMMON"

func set_mult(_mult):
    mult = _mult
    $Mult.text = str(mult) 

func position_mult():
    $Mult.anchor_left = 1 
    $Mult.anchor_top = 1
    $Mult.anchor_right = 1
    $Mult.anchor_bottom = 1
    var multsize = $Mult.get_size()
    $Mult.margin_left = -1 * multsize.x
    $Mult.margin_top =  -1 * multsize.y
