@tool
extends PanelContainer

func _on_resized():
    #return
    var icon_size = $HBox/AttributeIcon.size
    $HBox/AttributeValue.add_theme_font_size_override("font_size", icon_size.y-5)
