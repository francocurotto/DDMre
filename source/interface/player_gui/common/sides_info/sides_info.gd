extends AspectRatioContainer

# public functions
func setup(dice):
    for i in $HBox.get_child_count():
        var side_info = $HBox.get_child(i)
        side_info.type = dice.card.type
        side_info.crest = dice.sides[i].crest.TYPE
        side_info.mult = dice.sides[i].mult
        
