extends VBoxContainer

# onready variables
onready var idungeon = $IDungeon
onready var summon_info = $SummonCont/SummonInfo

func _ready():
    idungeon.connect("tile_button_toggled", summon_info, "on_tile_button_toggled")
