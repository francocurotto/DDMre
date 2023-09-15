extends PanelContainer

# variables
var dicepool
var dice_guis
var selected_dice_gui

# segnals
signal dice_gui_selected(dice)

func _ready():
    # define dice guis
    dice_guis = %Grid.get_children()
    # connections
    for dice_gui in dice_guis:
        dice_gui.dice_entered.connect(on_dice_entered)
        dice_gui.changed_position.connect(on_dice_changed_position)
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
        %DiceSelector.global_position = dice_gui.global_position
        %DiceSelector.scale_to_size(dice_gui.size)
        %DiceSelector.show()
    # update selected dice gui
    if selected_dice_gui != dice_gui:
        selected_dice_gui = dice_gui
        %DiceSelector.target = selected_dice_gui.global_position    
        dice_gui_selected.emit(selected_dice_gui.dice)

func on_sort_button_pressed():
    # remove dice guis from grid
    for dice_gui in %Grid.get_children():
        %Grid.remove_child(dice_gui)
    # sort
    dice_guis.reverse()
    # add dice guis with new order
    for dice_gui in dice_guis:
        %Grid.add_child(dice_gui)

func on_dice_changed_position(dice_gui):
    if dice_gui == selected_dice_gui:
        print(selected_dice_gui.position)
        %DiceSelector.target = selected_dice_gui.global_position
