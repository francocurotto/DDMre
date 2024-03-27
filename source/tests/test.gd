extends Control

signal sig

func _ready():
    var ref = load("res://tests/test2.gd").new()
    ref.setup(self)
    sig.emit()
