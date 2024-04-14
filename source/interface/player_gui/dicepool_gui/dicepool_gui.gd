extends PanelContainer

#region signals
signal dice_gui_selected(dice)
signal dice_sort_started
signal dice_sort_finished
signal roll_button_pressed
signal roll_finished
signal summon_button_pressed
#endregion

#region preload variables
const DiceSelector = preload("res://interface/player_gui/dicepool_gui/dice_selector/dice_selector.tscn")
#endregion

#region variables
var dicepool
var dice_guis
var dice_selector
var move_time = 0.7
var roll_dice_guis = []
var dim_candidates = []
var dim_dice
#endregion

#region builtin functions
func _ready():
    # define dice guis
    dice_guis = %Grid.get_children()
    # connections
    for dice_gui in dice_guis:
        dice_gui.dice_entered.connect(on_dice_entered)
        dice_gui.dice_roll_selected.connect(on_dice_roll_selected)
        dice_gui.dice_roll_unselected.connect(on_dice_roll_unselected)
    dice_guis[0].dice_move_finished.connect(func(): dice_sort_finished.emit())
    %DiceSort.sort_button_pressed.connect(on_sort_button_pressed)
#endregion

#region public functions
func setup(_dicepool):
    dicepool = _dicepool
    for i in len(dicepool):
        dice_guis[i].setup(dicepool[i])

func activate_dicepool():
    var tween = create_tween()
    tween.tween_property(self, "position", Vector2(0, -size.y), move_time)\
    .set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    await tween.finished
    enable_dice_guis()

func deactivate_dicepool():
    disable_dice_guis()
    %SummonButton.disabled = true
    # destroy dice_selector if exists
    if is_instance_valid(dice_selector):
        dice_selector.queue_free()
    # hide sides info
    %SidesInfo.modulate = Color(1,1,1,0)
    var tween = create_tween()
    tween.tween_property(self, "position", Vector2(0, 0), move_time)\
    .set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

func switch_to_summon_buttons():
    # used to activate summon button if on summon dice after roll
    if is_instance_valid(dice_selector):
        on_dice_entered(dice_selector.get_parent())
    %RollButton.visible = false
    %SummonButtons.visible = true

func get_dim_dice_index():
    return dicepool.find(dim_dice.dice)
#endregion

#region signals callbacks
func on_dice_entered(dice_gui):
    # case first selection
    if not is_instance_valid(dice_selector):
        # create dice selector and add to dice
        dice_selector = DiceSelector.instantiate()
        dice_gui.add_child(dice_selector)
        # make sides info visible
        %SidesInfo.modulate = Color(1,1,1,1)
    # case second selection
    else:
        # move dice selector to new dice
        dice_selector.move(dice_selector.global_position,
            dice_gui.global_position)
        dice_selector.reparent(dice_gui)
    # disable all roll button
    for _dice_gui in dice_guis:
        if dice_gui != _dice_gui:
            _dice_gui.roll_button.disabled = true
    # update sides info
    %SidesInfo.setup(dice_gui.dice)
    dice_gui_selected.emit(dice_gui.dice)
    # if dice is dim candidate
    %SummonButton.disabled = dicepool.find(dice_gui.dice) not in dim_candidates

func on_dice_roll_selected(dice_gui):
    # add dice to roll array
    roll_dice_guis.append(dice_gui)
    if len(roll_dice_guis) >= 3:
        # disabled all other dice
        for _dice_gui in dice_guis:
            if _dice_gui not in roll_dice_guis:
                _dice_gui.roll_selectable = false
        # activate roll
        %RollButton.disabled = false

func on_dice_roll_unselected(dice_gui):
    # remove dice from roll array
    roll_dice_guis.erase(dice_gui)
    # enable all dice
    for _dice_gui in dice_guis:
        _dice_gui.roll_selectable = true
    # disable roll
    %RollButton.disabled = true

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
    if is_instance_valid(dice_selector):
        pass
        var selected_index = sorted_dice_guis.find(dice_selector.get_parent())
        init_selector_pos = dice_selector.global_position
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
    if is_instance_valid(dice_selector):
        dice_selector.move(init_selector_pos, dest_selector_pos)

func on_dice_rolled(sides):
    # dice roll time
    var turns = [30, 50, 70]
    # roll each dice
    for i in len(roll_dice_guis):
        roll_dice_guis[i].roll(sides[i], turns[i])
    # when dice roll finished, do post-roll actions
    await roll_dice_guis[2].roll_sides.roll_finished
    roll_finished.emit(roll_dice_guis)

func _on_roll_button_pressed():
    %RollButton.disabled = true
    var roll_indeces = []
    for dice_gui in roll_dice_guis:
        roll_indeces.append(dicepool.find(dice_gui.dice))
    roll_button_pressed.emit(roll_indeces)

func _on_summon_button_pressed():
    dim_dice = dice_selector.get_parent()
    summon_button_pressed.emit(dim_dice)
#endregions    

#region private functions
func enable_dice_guis():
    for dice_gui in dice_guis:
        dice_gui.disabled = false
        
func disable_dice_guis():
    for dice_gui in dice_guis:
        dice_gui.disabled = true

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
#endregion
