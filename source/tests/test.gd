extends MarginContainer

func _input(event):
    if event is InputEventMouseButton and event.pressed:
        print("mouse pressed")
        var tween = create_tween()
        tween.tween_property($TextureRect, "position:x", 10, 1.0).as_relative()
