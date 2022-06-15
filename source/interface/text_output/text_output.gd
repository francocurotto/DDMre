extends PanelContainer

func on_engine_message(message):
    $OutputBox/Scroll/Text.text += "\n" + message
