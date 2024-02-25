extends PanelContainer

# variables
var engine
var player
var opponent

# onready variables
@onready var summon_info = %SummonInfo
@onready var dungeon_gui = %DungeonGUI

func _ready():
    dungeon_gui.tile_gui_toggled.connect(summon_info.on_tile_gui_toggled)

# public functions
func setup(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    %DungeonGUI.setup(player, engine.state.dungeon)
    %PlayerInfo.setup(player)

func _on_dicepool_button_toggled(toggled_on):
    if toggled_on:
        %DicepoolGUI.tween_up()
    else:
        %DicepoolGUI.tween_down()
