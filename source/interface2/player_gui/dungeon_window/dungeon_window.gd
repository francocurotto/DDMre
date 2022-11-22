extends VBoxContainer

# onready variables
onready var idungeon = $IDungeon

# setget functions
func set_dungeon(dungeon):
    idungeon.set_dungeon(dungeon)
