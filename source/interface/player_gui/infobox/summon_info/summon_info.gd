tool
extends VBoxContainer

# export variables
export (bool) var show_abilities = true setget set_show_abilities

# constants
const MODDICT = { 1.0 : Color(0.5,1.0, 1.0, 1.0), 
                 -1.0 : Color(1.0,0.75,0.75,1.0),
                  0.0 : Color(1.0,1.0, 1.0, 1.0)}

# variables
var player

# onready variables
onready var cardname = $TLAName/Name
onready var type = $TLAName/TLA/Type
onready var level = $TLAName/TLA/Level
onready var ability_icon = $TLAName/TLA/Ability
onready var attack_value = $ADH/Attack/AttackValue
onready var attack_icon = $ADH/Attack/AttackIcon
onready var defense_value = $ADH/Defense/DefenseValue
onready var defense_icon = $ADH/Defense/DefenseIcon
onready var currhealth_value = $ADH/Health/CurrHealthValue
onready var sep = $ADH/Health/Sep
onready var health_value = $ADH/Health/HealthValue
onready var health_icon = $ADH/Health/HealthIcon

# set functions 
func set_player(_player):
    player = _player

func set_summon(summon):
    set_summon_name(summon)
    type.texture = load("res://art/icons/TYPE_" + summon.card.type + ".png")
    level.text = str(summon.card.level)
    set_ability(summon.card.ability)
    set_summon_stats(summon)

func set_show_abilities(_show_abilities):
    show_abilities = _show_abilities
    $Abilities.visible = _show_abilities

# private functions
func set_summon_name(summon):
    if summon.is_item() and not summon in player.items: # case opponent item
        cardname.text = "???"
    else:
        cardname.text = summon.card.name

func set_ability(ability):
    if ability.empty():  # no ability icon
        ability_icon.texture = null
    else: # ability icon
        ability_icon.texture = load("res://art/icons/ABILITY.png")

func set_summon_stats(summon):
    if summon.is_monster(): # monster info
        set_monster_stats(summon)
        $ADH.visible = true
    else: # item info
        $ADH.visible = false

func set_monster_stats(summon):
    attack_value.text = str(summon.attack)
    attack_value.modulate = MODDICT[sign(summon.attack-summon.card.attack)]
    defense_value.text = str(summon.defense)
    defense_value.modulate = MODDICT[sign(summon.defense-summon.card.defense)]
    currhealth_value.text = str(summon.health)
    currhealth_value.modulate = MODDICT[sign(summon.health-summon.card.health)]
    health_value.text = str(summon.card.health)
    attack_icon.texture = load("res://art/icons/CREST_ATTACK.png")
    defense_icon.texture = load("res://art/icons/CREST_DEFENSE.png")
    health_icon.texture = load("res://art/icons/HEALTH.png")
