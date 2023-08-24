@tool
extends PanelContainer

func _on_resized():
    var icon_size = $HBox/AspectRatio/AttributeIcon.size
    $HBox/AttributeValue.add_theme_font_size_override("font_size", icon_size.y*0.5)
