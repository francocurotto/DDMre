extends MarginContainer

#region public functions
func set_dice_info(dice):
	set_summon_info(dice.summon)
	%SidesRow.set_sides(dice.sides, dice.summon.type)
	%SidesRow.visible = true # reactivate dice info

func set_summon_info(summon):
	%SidesRow.visible = false # hide dice info for summon only display
	%SummonIcon.texture = load("res://assets/icons/SUMMON_%s.svg" % summon.type)
	%Name.text = summon.summon_name
	%Level.value = summon.level
	%Attack.value = summon.attack
	%Defense.value = summon.defense
	%Health.value = summon.health
	# clear attack, defense and health if item
	var is_item = summon.type == "ITEM"
	%Attack.visible = not is_item
	%Defense.visible = not is_item
	%Health.visible = not is_item
#endregion
