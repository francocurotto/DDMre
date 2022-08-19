extends PanelContainer

# variables
var engine
var player
var opponent

# onready variables
onready var dicepool = $"%Dicepool"
onready var rollgui = $"%RollGUI"
onready var playerinfo = $"%PlayerInfo"
onready var opponentinfo = $"%OpponentInfo"
onready var iteminfo = $"%ItemInfo"
onready var dungeon = $"%Dungeon"

func _ready():
    #$PDBox/PRIBox/InfoBox/OpponentInfo.set_opponent_title()
    rollgui.hide_rolls()
    # connections
    dicepool.connect("roll_changed", self, "on_roll_changed")
    rollgui.connect("roll_pressed", self, "on_roll_pressed")
    rollgui.connect("endturn_pressed", self, "on_endturn_pressed")
    dicepool.connect("mouse_entered_dice", iteminfo, "on_mouse_entered_dice")
    dicepool.connect("mouse_exited_dice", iteminfo, "on_mouse_exited_dice")
    dungeon.connect("mouse_entered_dungobj", iteminfo, "on_mouse_entered_dungobj")
    dungeon.connect("mouse_exited_dungobj", iteminfo, "on_mouse_exited_dungobj")

# set functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool.set_dicepool(player.dicepool)
    playerinfo.set_infobox(player, "Player")
    opponentinfo.set_infobox(opponent, "Opponent")
    dungeon.set_dungeon(engine.dungeon, player)
    iteminfo.set_player(player)

func set_player_roll(sides):
    rollgui.update_roll_player(sides)

func set_opponent_roll(sides):
    rollgui.update_roll_opponent(sides)
    
func update_player_crestpool():
    playerinfo.update_crestpool()

func update_opponent_crestpool():
    opponentinfo.update_crestpool()

# signals callback
func on_state_update_roll():
    dicepool.enable_all()
    dicepool.release_all()
    rollgui.enable_roll()
    rollgui.hide_player_roll()
    rollgui.disable_endturn()

func on_state_update_dungeon():
    dicepool.disable_all()
    rollgui.disable_roll()
    rollgui.enable_endturn()

func on_roll_changed():
    rollgui.set_roll_button(dicepool.roll_ready())

func on_roll_pressed():
    var indeces = dicepool.get_indeces()
    engine.update({"name" : "ROLL", "dice" : indeces})

func on_endturn_pressed():
    engine.update({"name" : "ENDTURN"})
