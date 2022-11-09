extends VBoxContainer

# variables
var dicepool
var dimdice

# setget functions
func set_dicepool(_dicepool, _dimdice):
    dicepool = _dicepool
    dimdice = _dimdice
    set_diceitems()
    #disable_dim_dimensioned()

func set_diceitems():
    for i in range(get_child_count()):
        var dicecol = get_dicecol(i)
        dicecol.set_dice(dicepool[i])

func get_dicecol(idx):
    return get_child(idx)
