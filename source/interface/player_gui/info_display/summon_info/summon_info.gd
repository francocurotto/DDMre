tool
extends VBoxContainer

# onready variables
onready var upper_name = $UpperName
onready var tla_info = $SummonLine/TLAInfo
onready var summon_name = $SummonLine/Name
onready var attack_info = $SummonLine/MonsterStats/AttackInfo
onready var defense_info = $SummonLine/MonsterStats/DefenseInfo
onready var health_info = $SummonLine/MonsterStats/HealthInfo
onready var abilities = $Abilities

# setget functions
func set_summon(summon, player):
    tla_info.set_tla(summon.card)
    set_summon_name(summon, player)
    set_summon_stats(summon)
    set_summon_abilities(summon, player)
    visible = true

func clear():
    visible = false

func set_attacker_power(attacker, attacked):
    var power = attacker.get_power(attacked)
    attack_info.set_stat_value_color(power, attacker.card.attack)

# signals callbacks
func _on_SummonInfo_resized():
    var size_limit = $UpperName.get_size().y + $SummonLine/Name.get_size().y + get_constant("separation") + 1
    var size_limit2 = size_limit + $Abilities.get_size().y + get_constant("separation")
    if get_size().y > size_limit2:
        $UpperName.visible = true
        $SummonLine/Name. visible = false
        $Abilities.visible = true
    elif get_size().y > size_limit:
        $UpperName.visible = true
        $SummonLine/Name. visible = false
        $Abilities.visible = false  
    else:
        $UpperName.visible = false
        $SummonLine/Name. visible = true
        $Abilities.visible = false

# private functions
func set_summon_name(summon, player):
    if summon.is_item() and player != summon.player:
        summon_name.text = "???"
        upper_name.text = "???"
    else:
        summon_name.text = summon.card.name
        upper_name.text = summon.card.name

func set_summon_stats(summon):
    if summon.is_monster(): # monster info
        set_monster_stats(summon)
    else: # item info
        set_item_stats()

func set_summon_abilities(summon, player):
    $Abilities/Ability1.visible = false
    $Abilities/Ability2.visible = false
    if summon.is_monster() or player == summon.player:
        for i in range(len(summon.card.abilities)):
            var ability = summon.card.abilities[i]
            var ability_name = abilities.get_child(i)
            ability_name.text = Globals.ABIDICT[ability.name]["NAME"]
            ability_name.visible = true

func set_monster_stats(summon):
    attack_info.set_stat_value_color(summon.attack, summon.card.attack)
    defense_info.set_stat_value_color(summon.defense, summon.card.defense)
    health_info.set_stat_value_color(summon.health, summon.card.health)

func set_item_stats():
    attack_info.visible = false
    defense_info.visible = false
    health_info.visible = false
