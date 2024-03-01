extends PanelContainer

# variables
var player

# public functions
func setup(_player):
    player = _player
    %HeartsInfo.setup(player)
    %CrestpoolInfo.setup(player.crestpool)
    
# signals callbacks
func on_tile_gui_toggled(tile_gui, toggled_on):
    var content = tile_gui.tile.content
    if toggled_on and content == player.opponent.monster_lord:
        %HeartsInfo.setup(player.opponent)
        %CrestpoolInfo.setup(player.opponent.crestpool)
    else:
        setup(player)

func on_roll_finished(roll_dice_guis):
    var tween = create_tween()
    tween.set_parallel(true)
    %CrestpoolInfo.flash(tween, roll_dice_guis, 1.0)
    await tween.finished
    %CrestpoolInfo.setup(player.crestpool)
    tween = create_tween()
    tween.set_parallel(true)
    %CrestpoolInfo.flash(tween, roll_dice_guis, 0.0)
