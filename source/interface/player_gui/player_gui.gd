extends PanelContainer

var engine
var player
var opponent

func _ready():
    $PDBox/PRIBox/InfoBox/OpponentInfo.set_opponent_title()
    $PDBox/PRIBox/RollGUI.hide_rolls()
    # connections
    $PDBox/PRIBox/Dicepool.connect("roll_changed", self, "on_roll_changed")
    $PDBox/PRIBox/RollGUI.connect("roll_pressed", self, "on_roll_pressed")
    $PDBox/PRIBox/RollGUI.connect("endturn_pressed", self, "on_endturn_pressed")
    $PDBox/PRIBox/Dicepool.connect("mouse_entered_dice", 
        $PDBox/PRIBox/InfoBox/ItemInfo, "on_mouse_entered_dice")
    $PDBox/PRIBox/Dicepool.connect("mouse_exited_dice", 
        $PDBox/PRIBox/InfoBox/ItemInfo, "on_mouse_exited_dice")
    $PDBox/Dungeon.connect("mouse_entered_dungobj", 
        $PDBox/PRIBox/InfoBox/ItemInfo, "on_mouse_entered_dungobj")
    $PDBox/Dungeon.connect("mouse_exited_dungobj", 
        $PDBox/PRIBox/InfoBox/ItemInfo, "on_mouse_exited_dungobj")

func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    $PDBox/PRIBox/Dicepool.set_dicepool(player.dicepool)
    $PDBox/PRIBox/InfoBox/PlayerInfo.set_player(player)
    $PDBox/PRIBox/InfoBox/OpponentInfo.set_player(opponent)
    $PDBox/Dungeon.set_dungeon(engine.dungeon, player)
    $PDBox/PRIBox/InfoBox/ItemInfo.set_player(player)

func set_player_roll(sides):
    $PDBox/PRIBox/RollGUI.update_roll_player(sides)

func set_opponent_roll(sides):
    $PDBox/PRIBox/RollGUI.update_roll_opponent(sides)
    
func update_player_crestpool():
    $PDBox/PRIBox/InfoBox/PlayerInfo.update_crestpool()

func update_opponent_crestpool():
    $PDBox/PRIBox/InfoBox/OpponentInfo.update_crestpool()

func on_roll_changed():
    $PDBox/PRIBox/RollGUI.set_roll_button($PDBox/PRIBox/Dicepool.roll_ready())

func on_state_update_roll():
    $PDBox/PRIBox/Dicepool.enable_all()
    $PDBox/PRIBox/Dicepool.release_all()
    $PDBox/PRIBox/RollGUI.enable_roll()
    $PDBox/PRIBox/RollGUI.disable_endturn()

func on_state_update_dungeon():
    $PDBox/PRIBox/Dicepool.disable_all()
    $PDBox/PRIBox/RollGUI.disable_roll()
    $PDBox/PRIBox/RollGUI.enable_endturn()

func on_roll_pressed():
    var indeces = $PDBox/PRIBox/Dicepool.get_indeces()
    engine.update({"name" : "ROLL", "dice" : indeces})

func on_endturn_pressed():
    engine.update({"name" : "ENDTURN"})

func set_random_pool(_bool):
    $PDBox/PRIBox/Dicepool.set_random_pool(_bool)
