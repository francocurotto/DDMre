extends PanelContainer

# variables
var engine
var player
var opponent

func _ready():
    %DungeonGUI.tile_gui_toggled.connect(%SummonInfo.on_tile_gui_toggled)
    %DungeonGUI.tile_gui_toggled.connect(%PlayerInfo.on_tile_gui_toggled)
    %DicepoolGUI.dice_sort_started.connect(func(): 
        %DicepoolButton.disabled = true)
    %DicepoolGUI.dice_sort_finished.connect(func(): 
        %DicepoolButton.disabled = false)
    %DicepoolGUI.dice_gui_selected.connect(%SummonInfo.on_dice_gui_selected)
    %DicepoolGUI.roll_button_pressed.connect(input_roll_cmd)
    Events.dice_rolled.connect(on_dice_rolled)

# public functions
func setup(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    %DungeonGUI.setup(player, engine.state.dungeon)
    %PlayerInfo.setup(player)
    %DicepoolGUI.setup(player.dicepool)

# signals callbacks
func _on_dicepool_button_toggled(toggled_on):
    if toggled_on:
        %DicepoolGUI.activate_dicepool()
        %DungeonGUI.toggle_off_tile_gui()
    else:
        %DicepoolGUI.deactivate_dicepool()
        %SummonInfo.clear_info()

func on_dice_rolled(sides):
    if engine.state.player == player:
        %DicepoolGUI.on_dice_rolled(sides)

func input_roll_cmd(roll_indeces):
    engine.update({"cmd":"ROLL", "dice":roll_indeces})
