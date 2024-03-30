extends GridContainer

func _ready():
    var tween = create_tween()
    tween.tween_property($PanelContainer, "modulate", Color(1,1,1,1), 0)
    tween.tween_property($PanelContainer,  "scale", Vector2(1,1), 1).from(Vector2(0,0))
    tween.tween_property($PanelContainer2, "modulate", Color(1,1,1,1), 0)
    tween.tween_property($PanelContainer2, "scale", Vector2(1,1), 1).from(Vector2(0,0))
    tween.tween_property($PanelContainer3, "modulate", Color(1,1,1,1), 0)
    tween.tween_property($PanelContainer3, "scale", Vector2(1,1), 1).from(Vector2(0,0))
    tween.tween_property($PanelContainer4, "modulate", Color(1,1,1,1), 0)
    tween.tween_property($PanelContainer4, "scale", Vector2(1,1), 1).from(Vector2(0,0))
    print("a")
