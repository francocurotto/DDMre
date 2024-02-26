extends PanelContainer

# variables
var engine
var player
var opponent

# onready variables
#@onready var summon_info = %SummonInfo
#@onready var dungeon_gui = %DungeonGUI
#@onready var dicepool_gui = %DicepoolGUI

func _ready():
    %DungeonGUI.tile_gui_toggled.connect(%SummonInfo.on_tile_gui_toggled)
    %DicepoolGUI.dice_sort_started.connect(func(): 
        %DicepoolButton.disabled = true)
    %DicepoolGUI.dice_sort_finished.connect(func(): 
        %DicepoolButton.disabled = false)

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
