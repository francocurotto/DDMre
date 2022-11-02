extends VBoxContainer

# onready variables
onready var dice_icon = $CardContainer/DiceIcon
onready var level_stat =  $CardContainer/StatContainer/LevelStat
onready var attack_stat = $CardContainer/StatContainer/AttackStat
onready var defense_stat = $CardContainer/StatContainer/DefenseStat
onready var health_stat = $CardContainer/StatContainer/HealthStat
onready var dice_sides = $DiceSides

# setget functions
func set_dice(dice):
    dice_icon.set_type(dice.card.type)
    level_stat.set_stat_value(dice.level)
    attack_stat.set_stat_value(dice.card.attack)
    defense_stat.set_stat_value(dice.card.defense)
    health_stat.set_stat_value(dice.card.health)
