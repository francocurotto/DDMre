@tool
extends AspectRatioContainer

# public functions
func setup(dice):
    for i in $HBox.get_child_count():
        var side_info = $HBox.get_child(i)
        side_info.setup(dice.card.type, dice.sides[i])
        
