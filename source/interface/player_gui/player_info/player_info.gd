extends PanelContainer

# variables
var player

# public functions
func setup(_player):
    player = _player
    %HeartsInfo.setup(player)
    %CrestpoolInfo.setup(player.crestpool)
    
# signals callbacks
func on_tile_gui_pressed(tile_gui):
    var content = tile_gui.tile.content
    if content == player.opponent.monster_lord:
        %HeartsInfo.setup(player.opponent)
        %CrestpoolInfo.setup(player.opponent.crestpool)
    else:
        setup(player)

func on_roll_finished(roll_dice_guis):
    var tween = %CrestpoolInfo.flash(roll_dice_guis, 1.0)
    if tween:
        await tween.finished
    %CrestpoolInfo.setup(player.crestpool)
    %CrestpoolInfo.flash(roll_dice_guis, 0.0)
