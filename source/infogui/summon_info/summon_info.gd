extends MarginContainer

#region builtin functions
func _ready() -> void:
	Events.dice_focus_entered.connect(on_dice_focus_entered)
#endregion

#region signals callbacks
func on_dice_focus_entered(dice):
	%SidesRow.set_sides(dice.sides, dice.summon.type)
	%Name.text = dice.summon.summon_name
	%Level.original_value = dice.summon.level
	%Attack.original_value = dice.summon.attack
	%Defense.original_value = dice.summon.defense
	%Hearts.original_health = dice.summon.health
#endregion
