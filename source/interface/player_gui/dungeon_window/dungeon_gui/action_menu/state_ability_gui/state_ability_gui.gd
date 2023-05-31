extends VBoxContainer

#constants
const ability_guis_dict = {
    "DIMTRADECREST"  : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/state_ability_gui/dim_trade_crest_gui/dim_trade_crest_gui.tscn"),
    "DIMKILLTUNNEL"  : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_summon_gui/select_summon_gui.tscn"),
    "DIMKILLWEAKEST" : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_summon_gui/select_summon_gui.tscn"),
    "DIMCURE"        : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/state_ability_gui/select_summons_gui/select_summons_gui.tscn"),
    "MONSTERREBORN"  : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/state_ability_gui/monster_reborn_gui/monster_reborn_gui.tscn"),
}

# variables
var state
var ability
var active_gui

# onready variables
onready var ability_info = $AbilityInfo 
onready var controls = $Margins/Controls
onready var cast_button = $Margins/Controls/CastButton

# signals
signal cast_button_pressed(ability_dict)
signal skip_button_pressed
signal select_tile_gui_pressed(tiles)
signal select_summons_gui_pressed(tiles)
signal select_direction_pressed(ability, direction)
signal dice_gui_info_button_pressed(card)

func _ready():
    #ability_info.set_ability(ability) # TODO: ability_info
    if state.NAME == "DIMABILITY":
        ability = get_state_ability(state.summon)
        set_cast_button()
        if ability.name in ability_guis_dict:
            active_gui = ability_guis_dict[ability.name].instance().setup(self, ability)
    elif state.NAME == "ITEMABILITY":
        ability = get_state_ability(state.item)
        set_cast_button()
        if ability.name in ability_guis_dict:
            active_gui = ability_guis_dict[ability.name].instance().setup(self, ability, state.monster)
    ability_info.text = ability.name
    if active_gui:
        controls.add_child(active_gui)
        controls.move_child(active_gui, 0)
        
# public functions
func setup(action_menu, _state):
    state = _state
    connect("cast_button_pressed", action_menu, "on_state_cast_button_pressed")
    connect("skip_button_pressed", action_menu, "on_skip_button_pressed")
    connect("select_tile_gui_pressed", action_menu, "on_select_tile_gui_pressed")
    connect("select_summons_gui_pressed", action_menu, "on_select_summons_gui_pressed")
    connect("dice_gui_info_button_pressed", action_menu, "on_dice_gui_info_button_pressed")
    return self

func set_cast_button():
    if "COST" in ability and "CREST" in ability:
        on_ability_cost_changed(ability.COST, ability.CREST)
    elif "cost" in ability:
        on_ability_cost_changed(ability.COST, null)

# signals callbacks
func _on_CastButton_pressed():
    emit_signal("cast_button_pressed", get_ability_dict())

func _on_SkipButton_pressed():
    emit_signal("skip_button_pressed")

func on_ability_cost_changed(cost, crest):
    if crest:
        cast_button.text = "✨CAST (%d%s)" % [cost, Globals.CRESTICONS[crest]]
        cast_button.disabled = cost > ability.monster.player.crestpool.slots[crest]
    else:
        cast_button.disabled = true
    
func ability_castable(is_castable):
    cast_button.disabled = not is_castable

func on_select_tile_gui_toggled(pressed):
    if pressed:
        emit_signal("select_tile_gui_pressed", ability.get_select_tiles())
    else:
        cast_button.disabled = true

func on_select_summons_gui_toggled(pressed):
    if pressed:
        emit_signal("select_summons_gui_pressed", ability.get_select_tiles(), ability.NUMBER)
    else:
        cast_button.disabled = true

func on_dice_gui_info_button_pressed(card):
    emit_signal("dice_gui_info_button_pressed", card)

func on_select_tile_cancel_button_pressed():
    active_gui.on_select_tile_cancel_button_pressed()
    cast_button.disabled = true

func on_select_tile_select_button_pressed(tile):
    active_gui.on_select_tile_select_button_pressed(tile)
    if "CREST" in ability:
        cast_button.disabled = ability.COST > ability.monster.player.crestpool.slots[ability.CREST]
    else:
        cast_button.disabled = false

func on_select_summons_done_button_pressed(poslist):
    active_gui.on_select_summons_done_button_pressed(poslist)
    if not poslist.empty():
        cast_button.disabled = ability.COST > ability.monster.player.crestpool.slots[ability.CREST]

# private functions
func get_state_ability(summon):
    for _ability in summon.card.abilities:
        if _ability.is_dim_state() or _ability.is_item_state():
            return _ability

func get_ability_dict():
    var ability_dict = {"name" : ability.name}
    if active_gui:
        ability_dict.merge(active_gui.get_ability_dict())
    return ability_dict
