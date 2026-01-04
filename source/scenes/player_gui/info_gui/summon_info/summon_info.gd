@tool
extends MarginContainer

#region export variables
@export var hide_sides = false :
	set(_hide_sides):
		hide_sides = _hide_sides
		%SidesRow.visible = not hide_sides
#endregion

#region public functions
func set_dice_info(dice):
	set_summon_info(dice.player, dice.summon)
	%SidesRow.set_sides(dice.sides, dice.summon.type)
	hide_sides = false # reactivate dice info

func set_summon_info(player, summon):
	hide_sides = true # hide dice info for summon only display
	%SummonIcon.texture = load("res://assets/icons/SUMMON_%s.svg" % summon.type)
	if player == summon.player or summon.type != "ITEM":
		%Name.text = summon.summon_name
	else:
		%Name.text = "???"
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
