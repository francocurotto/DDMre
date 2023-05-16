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
var playerid
var inittrans
var net_index = 18
var rot_index

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

# public functions
func disable_buttons():
    for main_button in main_buttons.get_children():
        main_button.disabled = true

func enable_net_buttons():
    for button in net_buttons:
       button.disabled = false

# signals callbacks
func on_tile_dim_button_pressed():
    enable_net_buttons()
    on_net_button_pressed()

func on_net_positioned(can_dimension):
    dim_button.disabled = not can_dimension

func _on_NetPrevButton_pressed():
    net_index -= 1
    on_net_button_pressed()
    
func _on_NetNextButton_pressed():
    net_index += 1
    on_net_button_pressed()

func _on_TCWButton_pressed():
    var adder = -(playerid*2-3)
    rot_index = (rot_index+adder) % len(ROTATIONS)
    on_net_button_pressed()

func _on_TAWButton_pressed():
    var adder = -(playerid*2-3)
    rot_index = (rot_index+adder) % len(ROTATIONS)
    on_net_button_pressed()

func _on_DimButton_pressed():
    emit_signal("dim_button_pressed")

func on_net_button_pressed():
    var netname = NETS[net_index%len(NETS)][0]
    var reflections = NETS[net_index%len(NETS)][1]
    var rotations = ROTATIONS[rot_index%len(ROTATIONS)]
    var trans_list = inittrans + reflections + rotations
    emit_signal("net_button_pressed", netname, reflections)

