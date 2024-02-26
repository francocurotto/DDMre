extends PanelContainer

# preload variables
const DiceSelector = preload("res://interface/player_gui/dicepool_gui/dice_selector/dice_selector.tscn")

# variables
var dicepool
var dice_guis
var selected_dice_gui
var dice_selector
var move_time = 0.7

# signals
signal dice_gui_selected(dice)
signal dice_sort_started
signal dice_sort_finished

func _ready():
    # define dice guis
    dice_guis = %Grid.get_children()
    # connections
    for dice_gui in dice_guis:
        dice_gui.dice_entered.connect(on_dice_entered)
    dice_guis[0].dice_move_finished.connect(func(): dice_sort_finished.emit())
    %DiceSort.sort_button_pressed.connect(on_sort_button_pressed)

# public functions
func setup(_dicepool):
    dicepool = _dicepool
    for i in len(dicepool):
        dice_guis[i].setup(dicepool[i])

func activate_dicepool():
    var tween = create_tween()
    tween.tween_property(self, "position", Vector2(0, -size.y), move_time)\
    .set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    enable_buttons()

func deactivate_dicepool():
    disable_buttons()
    # destroy dice_selector if exists
    if selected_dice_gui != null:
        selected_dice_gui = null
        dice_selector.queue_free()
    var tween = create_tween()
    tween.tween_property(self, "position", Vector2(0, 0), move_time)\
    .set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

# signals callbacks
func on_dice_entered(dice_gui):
    # case first selection
    if selected_dice_gui == null:
        dice_selector = DiceSelector.instantiate()
        dice_gui.add_child(dice_selector)
    # update selected dice gui
    if selected_dice_gui != dice_gui:
        selected_dice_gui = dice_gui
        dice_selector.move(dice_selector.global_position,
            selected_dice_gui.global_position)
        dice_gui_selected.emit(selected_dice_gui.dice)

func on_sort_button_pressed():
    dice_sort_started.emit()
    # ceeate array of sorted dice guis
    var sorted_dice_guis = dice_guis.duplicate()
    sorted_dice_guis.sort_custom(sort_dice_guis)
    # get dice initial and destination positions
    var init_pos = []
    var dest_pos = []
    for i in len(dice_guis):
        init_pos.append(sorted_dice_guis[i].global_position)
        dest_pos.append(%Grid.get_child(i).global_position)
    # get dice selector inital and destination positions
    var init_selector_pos
    var dest_selector_pos
    if selected_dice_gui:
        var selected_index = sorted_dice_guis.find(selected_dice_gui)
        init_selector_pos = selected_dice_gui.global_position
        dest_selector_pos = dest_pos[selected_index]
    # remove dice from grid
    for dice_gui in %Grid.get_children():
        %Grid.remove_child(dice_gui)
    # add dice in new order
    for dice_gui in sorted_dice_guis:
        %Grid.add_child(dice_gui)
    # move dice animation
    for i in len(sorted_dice_guis):
        sorted_dice_guis[i].move(init_pos[i], dest_pos[i])
    # move selector animation
    if selected_dice_gui:
        dice_selector.move(init_selector_pos, dest_selector_pos)

# private functions
func enable_buttons():
    for dice_gui in dice_guis:
        dice_gui.enabled = true

func disable_buttons():
    for dice_gui in dice_guis:
        dice_gui.enabled = false

func sort_dice_guis(dice_gui1, dice_gui2):
    # get dice and crest
    var dice1 = dice_gui1.dice
    var dice2 = dice_gui2.dice
    var sort_crest = %DiceSort.sort_crest
    # choose sorting type
    # sort first by level and then by crest
    if %DiceSort.sort_level and sort_crest:
        return dice1.lesser_level_crest(dice2, sort_crest)
    # sort by level
    elif %DiceSort.sort_level:
        return dice1.lesser_level(dice2)
    # sort by crest     
    elif sort_crest:
        return dice1.greater_crest(dice2, sort_crest)
    # original sort
    else:
        return dicepool.find(dice1) < dicepool.find(dice2)
