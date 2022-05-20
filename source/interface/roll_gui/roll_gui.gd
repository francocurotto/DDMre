tool
extends HBoxContainer

export (bool) var roll_player_dice setget set_random_roll_player
export (bool) var roll_opp_dice setget set_random_roll_opponent

signal roll_pressed

func set_roll_button(enable):
    $PlayerPanel/BPBox/RollButton.disabled = not enable

func update_roll_player(sides):
    $PlayerPanel/BPBox/PlayerRoll.set_roll(sides)
    $PlayerPanel/BPBox/PlayerRoll.show_roll(true)

func update_roll_opponent(sides):
    $OppPanel/LOBox/OppRoll.set_roll(sides)
    $OppPanel/LOBox/OppRoll.show_roll(true)

func _on_RollButton_pressed():
    emit_signal("roll_pressed")

func hide_rolls():
    $PlayerPanel/BPBox/PlayerRoll.show_roll(false)
    $OppPanel/LOBox/OppRoll.show_roll(false)

func set_random_roll_player(_bool):
    $PlayerPanel/BPBox/PlayerRoll.set_random_roll(_bool)

func set_random_roll_opponent(_bool):
    $OppPanel/LOBox/OppRoll.set_random_roll(_bool)
