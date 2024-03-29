extends Control

signal sig

func _ready():
    var tween = create_tween()
    tween.tween_property(self, "modulate", Color.RED, 1)
    print("a")
    tween.tween_property(self, "scale", Vector2(), 1)
    print("b")
