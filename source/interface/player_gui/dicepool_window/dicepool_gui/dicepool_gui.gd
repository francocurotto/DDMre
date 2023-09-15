extends PanelContainer

# preload variables
const DiceSelector = preload("res://interface/player_gui/dicepool_window/dicepool_gui/dice_selector/dice_selector.tscn")

# variables
var dicepool
var dice_guis
var selected_dice_gui
var dice_selector

# signals
signal dice_gui_selected(dice)

func _ready():
    # define dice guis
    dice_guis = %Grid.get_children()
    # connections
    for dice_gui in dice_guis:
        dice_gui.dice_entered.connect(on_dice_entered)
    %DiceSort.sort_button_pressed.connect(on_sort_button_pressed)

# public functions
func setup(_dicepool):
    dicepool = _dicepool
    for i in len(dicepool):
        dice_guis[i].setup(dicepool[i])
        
# signals callbacks
func on_dice_entered(dice_gui):
    # case first selection
    if selected_dice_gui == null:
        dice_selector = DiceSelector.instantiate()
        dice_gui.add_child(dice_selector)
    # update selected dice gui
    if selected_dice_gui != dice_gui:
        selected_dice_gui = dice_gui
        dice_selector.move(selected_dice_gui.global_position)
        dice_gui_selected.emit(selected_dice_gui.dice)

func on_sort_button_pressed():
    # get dice gui positions in order
    var positions = []
    for dice_gui in dice_guis:
        positions.append(dice_gui.global_position)
    # remove dice guis from grid
    for dice_gui in dice_guis:
        %Grid.remove_child(dice_gui)
    # requested sort
    dice_guis.sort_custom(sort_dice_guis)
    # add dice guis with new order
    for dice_gui in dice_guis:
        %Grid.add_child(dice_gui)
    # move dice animation
    for i in len(dice_guis):
        dice_guis[i].move(positions[i])
    # move dice selector
    dice_selector.move(positions[selected_dice_gui.get_index()])

# private functions
func sort_dice_guis(dice_gui1, dice_gui2):
    # get dice and crest
    var dice1 = dice_gui1.dice
    var dice2 = dice_gui2.dice
    var sort_crest = %DiceSort.sort_crest
    # choose sorting type
    # sort first by level and then by crest
    if %DiceSort.sort_level and sort_crest:
        return dice1.greater_level_crest(dice2, sort_crest)
    # sort by level
    elif %DiceSort.sort_level:
        return dice1.greater_level(dice2)
    # sort by crest     
    elif sort_crest:
        return dice1.greater_crest(dice2, sort_crest)
    # original sort
    else:
        return dicepool.find(dice1) < dicepool.find(dice2)
