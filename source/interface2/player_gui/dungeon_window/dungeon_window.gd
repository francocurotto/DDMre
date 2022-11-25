extends VBoxContainer

# onready variables
onready var idungeon = $IDungeon
onready var summon_info = $SummonCont/SummonInfo
onready var dungeon_buttons = $DungeonButtons

func _ready():
    idungeon.connect("tile_button_toggled", summon_info, "on_tile_button_toggled")
    idungeon.connect("tile_button_toggled", dungeon_buttons, "on_tile_button_toggled")

# signals callbacks
func on_state_update_roll():
    dungeon_buttons.deactivate()

func on_state_update_dungeon():
    dungeon_buttons.activate()
