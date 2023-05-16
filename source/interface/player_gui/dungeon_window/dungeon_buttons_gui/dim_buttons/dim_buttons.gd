extends MarginContainer

# constants
const INITDICT = {1:[], 2:["FUD"]}
const ROTATIONS = [[], ["TCW"], ["TCW", "TCW"], ["TAW"]]
const NETS = [["X1", []],
              ["T1", []],
              ["Z1", []], 
              ["Z1", ["FLR"]], 
              ["X2", []], 
              ["X2", ["FLR"]], 
              ["T2", []], 
              ["T2", ["FLR"]],
              ["Z2", []], 
              ["Z2", ["FLR"]], 
              ["M1", []], 
              ["M1", ["FLR"]], 
              ["M2", []], 
              ["M2", ["FLR"]], 
              ["S1", []], 
              ["S1", ["FLR"]], 
              ["S2", []], 
              ["S2", ["FLR"]], 
              ["L1", []],
              ["L1", ["FLR"]]]

# variables
var player
var inittrans
var net_index = 18
var rot_index = 0
var pos

# onready variables
onready var main_buttons = $MainButtons
onready var net_prev_button = $MainButtons/NetPrevButton
onready var net_next_button = $MainButtons/NetNextButton
onready var tcw_button = $MainButtons/TCWButton
onready var taw_button = $MainButtons/TAWButton
onready var dim_button = $MainButtons/DimButton
onready var net_buttons = [net_prev_button, net_next_button, tcw_button, taw_button]

# signals
signal net_button_pressed
signal dim_button_pressed

# setget functions
func set_dim_buttons(_player):
    player = _player
    inittrans = INITDICT[player.id]
    set_net_icons()

# public functions
func disable_buttons():
    for main_button in main_buttons.get_children():
        main_button.disabled = true

func enable_net_buttons():
    for button in net_buttons:
       button.disabled = false

func get_netdata():
    var netname = NETS[net_index%len(NETS)][0]
    var reflections = NETS[net_index%len(NETS)][1]
    var rotations = ROTATIONS[rot_index%len(ROTATIONS)]
    var trans_list = inittrans + reflections + rotations
    return {"netname":netname, "pos":pos, "trans_list":trans_list}

# signals callbacks
func on_tile_dim_button_pressed(_pos):
    pos = _pos
    enable_net_buttons()
    on_net_button_pressed()

func on_net_positioned(can_dimension):
    dim_button.disabled = not can_dimension

func _on_NetPrevButton_pressed():
    net_index -= 1
    on_net_button_pressed()
    set_net_icons()
    
func _on_NetNextButton_pressed():
    net_index += 1
    on_net_button_pressed()
    set_net_icons()

func _on_TCWButton_pressed():
    var adder = -(player.id*2-3)
    rot_index = (rot_index+adder) % len(ROTATIONS)
    on_net_button_pressed()

func _on_TAWButton_pressed():
    var adder = -(player.id*2-3)
    rot_index = (rot_index+adder) % len(ROTATIONS)
    on_net_button_pressed()

func _on_DimButton_pressed():
    emit_signal("dim_button_pressed")

func on_net_button_pressed():
    var netdata = get_netdata()
    emit_signal("net_button_pressed", netdata["netname"], netdata["pos"], netdata["trans_list"])

# private functions
func set_net_icons():
    set_net_icon(net_prev_button, -1)
    set_net_icon(net_next_button, 1)

func set_net_icon(button, offset):
    var netlist = NETS[(net_index+offset)%len(NETS)]
    var netname = netlist[0]
    var icon = load("res://art/icons/NET_"+netname+".png")
    if not netlist[1].empty():
        var image = icon.get_data()
        image.flip_x()
        icon = ImageTexture.new()
        icon.create_from_image(image)     
    button.icon = icon
