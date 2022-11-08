extends Node

func _input(event):
    if event is InputEventMouseMotion:
        print(event.position)
        #$Label.text = str(event.position)
