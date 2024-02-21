extends PanelContainer

# signals callbacks
func on_tile_gui_toggled(tile_gui, toggled_on):
    if toggled_on and tile_gui.tile.content.is_summon():
        %Name.text = tile_gui.tile.content.card.name
    else:
        %Name.text = ""
