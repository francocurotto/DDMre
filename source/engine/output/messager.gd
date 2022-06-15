extends Reference

signal engine_message(message)

func _init(engine):
    engine.state.connect("dice_rolled", self, "on_dice_rolled")

func on_dice_rolled(sides, player):
    var string = player.name + " rolled "
    for i in range(sides.size()):
        string += Globals.CRESTDICT[sides[i].crest.NAME]
        string += str(sides[i].mult)
        if not i==sides.size()-1 :
            string += ","
    emit_signal("engine_message", string)
    
    
