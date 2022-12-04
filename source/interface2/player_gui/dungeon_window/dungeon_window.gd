extends VBoxContainer

# onready variables
onready var idungeon = $IDungeon
onready var summon_info = $SummonCont/SummonInfo
onready var dungeon_buttons = $DungeonButtons
onready var dim_buttons = $DimButtons
onready var move_menu = $IDungeon/MoveMenu

func _ready():
    idungeon.connect("tile_select_button_toggled", summon_info, "on_tile_select_button_toggled")
    idungeon.connect("tile_select_button_toggled", dungeon_buttons, "on_tile_select_button_toggled")
    idungeon.connect("tile_dim_button_pressed", dim_buttons, "on_tile_dim_button_pressed")
    idungeon.connect("net_updated", dim_buttons, "on_net_updated")
    idungeon.connect("menu_opened", dungeon_buttons, "on_menu_opened")
    dungeon_buttons.connect("move_button_pressed", idungeon, "on_move_button_pressed")
    dungeon_buttons.connect("attack_button_pressed", idungeon, "on_attack_button_pressed")
    dungeon_buttons.connect("cancel_button_pressed", self, "on_state_update_dungeon")
    dim_buttons.connect("net_button_pressed", idungeon, "on_net_button_pressed")
    dim_buttons.connect("FLR_button_pressed", idungeon, "on_FLR_button_pressed")
    dim_buttons.connect("FUD_button_pressed", idungeon, "on_FUD_button_pressed")
    dim_buttons.connect("TCW_button_pressed", idungeon, "on_TCW_button_pressed")
    dim_buttons.connect("TAW_button_pressed", idungeon, "on_TAW_button_pressed")
    dim_buttons.connect("dim_button_pressed", idungeon, "on_dim_button_pressed")
    move_menu.connect("menu_canceled", self, "reset_to_dungeon")

# public functions
func reset_to_dungeon():
    idungeon.reset()
    dungeon_buttons.activate()
    dungeon_buttons.switch_to_action_buttons()
    switch_to_dungeon_buttons()

# signals callbacks
func on_state_update_roll():
    idungeon.reset()
    dungeon_buttons.deactivate()

func on_state_update_dungeon():
    reset_to_dungeon()

func on_dice_dim_button_pressed():
    idungeon.on_dice_dim_button_pressed()
    switch_to_dim_buttons()

func on_dice_dim_button_released():
    reset_to_dungeon()

# private functions
func switch_to_dim_buttons():
    dim_buttons.visible = true
    dungeon_buttons.visible = false

func switch_to_dungeon_buttons():
    dungeon_buttons.visible = true
    dim_buttons.visible = false
