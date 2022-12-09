extends VBoxContainer

# onready variables
onready var idungeon = $IDungeon
onready var summon_info = $SummonCont/SummonInfo
onready var dungeon_buttons = $DungeonButtons
onready var dim_buttons = $DimButtons
onready var move_menu = $IDungeon/MoveMenu

# public functions
func reset_to_dungeon():
    idungeon.reset()
    dungeon_buttons.activate()
    dungeon_buttons.switch_to_action_buttons()
    dungeon_buttons.cancel_button.disabled = false
    dim_buttons.disable_buttons()
    switch_to_dungeon_buttons()

# signals callbacks
func on_state_update_roll():
    idungeon.reset()
    dungeon_buttons.deactivate()

func on_state_update_dungeon():
    reset_to_dungeon()

func on_state_update_reply(attacker, attacked):
    idungeon.open_reply_menu(attacker, attacked)

func on_dice_dim_button_pressed(dice):
    idungeon.on_dice_dim_button_pressed(dice)
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
