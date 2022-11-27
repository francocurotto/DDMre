extends VBoxContainer

# onready variables
onready var idungeon = $IDungeon
onready var summon_info = $SummonCont/SummonInfo
onready var dungeon_buttons = $DungeonButtons

func _ready():
    idungeon.connect("tile_button_toggled", summon_info, "on_tile_button_toggled")
    idungeon.connect("tile_button_toggled", dungeon_buttons, "on_tile_button_toggled")
    dungeon_buttons.connect("move_button_pressed", idungeon, "on_move_button_pressed")
    dungeon_buttons.connect("attack_button_pressed", idungeon, "on_attack_button_pressed")
    dungeon_buttons.connect("cancel_button_pressed", self, "on_state_update_dungeon")

# signals callbacks
func on_state_update_roll():
    dungeon_buttons.deactivate()

func on_state_update_dungeon():
    idungeon.reset()
    dungeon_buttons.activate()
