extends HBoxContainer

# public functions
func add_dice(idx, dice):
    for diceframe in get_children():
        if diceframe.is_empty():
            diceframe.set_dice(idx, dice)
            return
        elif diceframe.idx > idx:
            var old_dice = diceframe.dice
            diceframe.set_dice(idx, dice)
            dice = old_dice

func remove_dice(idx):
    for diceframe in get_children():
        if diceframe.idx == idx:
            diceframe.remove_dice()
            flush_dice_left()
            return

# private functions
func flush_dice_left():
    for diceframe in get_children():
        if diceframe.empty():
            move_child(diceframe, 2)
