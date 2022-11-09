extends VBoxContainer

# onready variables
onready var dicepool_column = $DicepoolPanel/DicepoolVBox/DicepoolColumn

# setget functions
func set_dicepool(dicepool, dimdice):
    dicepool_column.set_dicepool(dicepool, dimdice)
