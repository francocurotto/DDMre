extends PanelContainer

#region public functions
func set_dice(i, dice_dict):
	$Grid.get_child(i).set_dice(dice_dict)
#endregion
