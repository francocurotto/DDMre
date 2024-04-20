extends PanelContainer

#region variables
var engine
var player
var opponent
#endregion

#region builtin functions
func _ready():
    %DungeonGUI.tile_gui_pressed.connect(%SummonInfo.on_tile_gui_pressed)
    %DungeonGUI.tile_gui_pressed.connect(%PlayerInfo.on_tile_gui_pressed)
    %DungeonGUI.net_gui_changed.connect(on_net_gui_changed)
    %DicepoolGUI.dice_sort_started.connect(func(): 
        %DicepoolButton.mouse_filter = MOUSE_FILTER_IGNORE)
    %DicepoolGUI.dice_sort_finished.connect(func():
        %DicepoolButton.mouse_filter = MOUSE_FILTER_STOP)
    %DicepoolGUI.dice_gui_selected.connect(%SummonInfo.on_dice_gui_selected)
    %DicepoolGUI.roll_button_pressed.connect(input_roll_cmd)
    %DicepoolGUI.roll_finished.connect(on_roll_finished)
    %DicepoolGUI.summon_button_pressed.connect(on_summon_button_pressed)
    Events.dice_rolled.connect(on_dice_rolled)
    Events.dice_dimensioned.connect(on_dice_dimensioned)
#endregion

#region public functions
func setup(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    %DungeonGUI.setup(player, engine.state)
    %PlayerInfo.setup(player)
    %DicepoolGUI.setup(player.dicepool)
#endregion

#region signals callbacks
func _on_dicepool_button_toggled(toggled_on):
    if toggled_on:
        %DicepoolGUI.activate_dicepool()
        %DungeonGUI.on_dicepool_button_activated()
        %SummonInfo.reset_default()
        %SummonInfo.display_clear()
        switch_to_end_turn_button()
    else:
        %DicepoolGUI.deactivate_dicepool()
        %DungeonGUI.on_dicepool_button_deactivated()
        %SummonInfo.display_clear()
        %SummonInfo.reset_default()

func on_dice_rolled(sides):
    if engine.state.player == player:
        %DicepoolGUI.on_dice_rolled(sides)

func on_dice_dimensioned(summon, net):
    %DungeonGUI.on_dice_dimensioned(summon, net)

func on_roll_finished(roll_dice_guis):
    %PlayerInfo.on_roll_finished(roll_dice_guis)
    if engine.state.NAME == "DIMENSION":
        %DicepoolGUI.dim_candidates = engine.state.dim_candidates
        %DicepoolGUI.switch_to_summon_buttons()

func on_summon_button_pressed(dice_gui):
    %DicepoolButton.button_pressed = false
    %SummonInfo.default = dice_gui.dice
    %DungeonGUI.on_summon_button_pressed(dice_gui)
    switch_to_dim_button()

func on_net_gui_changed(can_dimension):
    %DimButton.disabled = not can_dimension

func input_roll_cmd(roll_indeces):
    engine.update({"cmd":"ROLL", "dice":roll_indeces})

func _on_dim_button_pressed():
    %DimButton.disabled = true
    var dim_cmd = {"cmd" : "DIM"}
    dim_cmd.merge({"dice" : %DicepoolGUI.get_dim_dice_index()})
    dim_cmd.merge(%DungeonGUI.get_dim_params())
    engine.update(dim_cmd)
#endregion

#region private functions
func switch_to_end_turn_button():
    for button in %ActionButtons.get_children():
        button.visible = false
    %EndTurnButton.visible = true

func switch_to_dim_button():
    for button in %ActionButtons.get_children():
        button.visible = false
    %DimButton.visible = true
#endregion
