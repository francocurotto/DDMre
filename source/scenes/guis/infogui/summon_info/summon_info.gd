extends MarginContainer

#region public functions
func set_dice_info(dice):
	%SidesRow.set_sides(dice.sides, dice.summon.type)
	%SummonIcon.texture = load("res://assets/SUMMON_%s.svg" % dice.summon.type)
	%Name.text = dice.summon.summon_name
	%Level.original_value = dice.summon.level
	%Attack.original_value = dice.summon.attack
	%Defense.original_value = dice.summon.defense
	%Hearts.original_health = dice.summon.health
	# clear attack,defense and hearts if item
	var is_item = dice.summon.type == "ITEM"
	%Attack.visible = not is_item
	%Defense.visible = not is_item
	%Hearts.visible = not is_item
	$VBoxContainer.visible = true
#endregion
