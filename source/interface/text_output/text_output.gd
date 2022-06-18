extends PanelContainer

func on_engine_message(message):
    # if first  message don't add \n
    if not $OutputBox/Scroll/Text.text == "":
        $OutputBox/Scroll/Text.text += "\n"
    $OutputBox/Scroll/Text.text += message
    # auto scroll to the bottom
    yield(get_tree(), "idle_frame")
    var bottom_scroll = $OutputBox/Scroll.get_v_scrollbar().max_value
    $OutputBox/Scroll.scroll_vertical = bottom_scroll
 
