extends TextureRect

# set functions
func set_side(side):
    set_crest(side.crest.NAME)
    set_mult(side.mult)
    position_mult(side.crest.NAME)

func set_crest(crest):
    texture = load("res://art/icons/CREST_" + crest  + ".png")

func set_mult(mult):
    $Mult.text = str(mult)

# private functions
func position_mult(crest):
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
