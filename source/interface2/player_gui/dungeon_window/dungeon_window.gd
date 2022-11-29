extends VBoxContainer

# onready variables
onready var idungeon = $IDungeon
onready var summon_info = $SummonCont/SummonInfo
onready var dungeon_buttons = $DungeonButtons
onready var dim_buttons = $DimButtons

func _ready():
    idungeon.connect("tile_select_button_toggled", summon_info, "on_tile_select_button_toggled")
    idungeon.connect("tile_select_button_toggled", dungeon_buttons, "on_tile_select_button_toggled")
    idungeon.connect("tile_dim_button_pressed", dim_buttons, "on_tile_dim_button_pressed")
    dungeon_buttons.connect("move_button_pressed", idungeon, "on_move_button_pressed")
    dungeon_buttons.connect("attack_button_pressed", idungeon, "on_attack_button_pressed")
    dungeon_buttons.connect("cancel_button_pressed", self, "on_state_update_dungeon")

# signals callbacks
func on_state_update_roll():
    dungeon_buttons.deactivate()

func on_state_update_dungeon():
    idungeon.reset()
    dungeon_buttons.activate()

func on_dice_dim_button_pressed(dicecol):
    switch_to_dim_buttons()
    idungeon.on_dice_dim_button_pressed(dicecol)

func on_dice_dim_button_released():
    switch_to_dungeon_buttons()

# private functions
func switch_to_dim_buttons():
    dim_buttons.visible = true
    dungeon_buttons.visible = false

func switch_to_dungeon_buttons():
    dungeon_buttons.visible = true
    dim_buttons.visible = false
