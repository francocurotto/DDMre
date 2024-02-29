@tool
extends MarginContainer

# export variables
@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") 
var type : String = "DRAGON" :
    set(_type):
        type = _type
        if has_node("DiceIcon"):
            $DiceIcon.self_modulate = COLORS[type]

@export_range(1, 4) var level = 1 :
    set(_level):
        level = _level
        if has_node("%LevelLabel"):
            %LevelLabel.text = str(level)

@export var roll_selectable: bool = true :
    set(_roll_selectable):
        roll_selectable = _roll_selectable
        if roll_selectable:
            $DiceIcon.modulate = Color(1,1,1,1)
        else:
            $DiceIcon.modulate = Color(1,1,1,0.5)

# constants
const SideInfo = preload("res://interface/player_gui/dicepool_gui/sides_info/side_info/side_info.tscn")
const COLORS = {
    "DRAGON"      : Color(1.0,0.3,0.3),
    "SPELLCASTER" : Color(0.8,0.8,0.8),
    "UNDEAD"      : Color(1.0,1.0,0.3),
    "BEAST"       : Color(0.3,1.0,0.3),
    "WARRIOR"     : Color(0.3,0.3,1.0),
    "ITEM"        : Color(0.3,0.3,0.3)}

# variables
var dice
#var enabled = true
var move_time = 0.5

# onready variables
@onready var roll_button = %RollButton

# signals
signal dice_entered(dice_gui)
signal dice_move_finished
signal dice_roll_selected(dice_gui)
signal dice_roll_unselected(dice_gui)

# public functions
func setup(_dice):
    dice = _dice
    type = dice.card.type
    level = dice.level
    add_side_infos()

func move(init_pos, dest_pos):
    var tween = create_tween()
    tween.finished.connect(func(): dice_move_finished.emit())
    tween.tween_property($DiceIcon, "global_position", dest_pos, move_time)\
        .from(init_pos).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

func roll(side, turns):
    $DiceIcon.visible = false
    $SideMargin.visible = true
    for _i in turns:
        var i = randi() % $SideMargin.get_child_count()
        $SideMargin.get_children().map(func(side_info): side_info.visible=false)
        $SideMargin.get_child(i).visible = true
        await get_tree().create_timer(0.03).timeout
    $SideMargin.get_children().map(func(side_info): side_info.visible=false)
    for side_info in $SideMargin.get_children():
        if side_info.equal_to_side(side):
            side_info.visible = true
            break

# signals callbacks
func _on_resized():
    var min_size = min(size.y, size.x)
    %LevelLabel.add_theme_font_size_override("font_size", min_size/4)
    %LevelLabel.add_theme_constant_override("outline_size", min_size/8)

func _input(event):
    var rect = Rect2(global_position, size)
    # check event type
    if (event is InputEventScreenTouch and event.pressed or
        event is InputEventScreenDrag):
        # check event inside dice
        if rect.has_point(event.position):
            dice_entered.emit(self)
    elif event is InputEventScreenTouch and not event.pressed:
        # check event inside dice
        if rect.has_point(event.position) and roll_selectable:
            roll_button.disabled = false

func _on_roll_button_toggled(toggled_on):
    if toggled_on:
        %RollButton.icon = load("res://assets/icons/ROLL_SELECTOR.svg")
        dice_roll_selected.emit(self)
    else:
        %RollButton.icon = null
        dice_roll_unselected.emit(self)

# private functions
func add_side_infos():
    for side in dice.sides:
        # check if side already in node
        var not_in_node = true
        for side_info in $SideMargin.get_children():
            if side_info.equal_to_side(side):
                not_in_node = false
                break
        if not_in_node:
            var side_info = SideInfo.instantiate()
            side_info.type = dice.card.type
            side_info.crest = side.crest.TYPE
            side_info.mult = side.mult
            $SideMargin.add_child(side_info)
