extends RefCounted

# preloads
const Dicelib = preload("res://engine/dice/dicelib.gd")
const Player = preload("res://engine/player/player.gd")
const Dungeon = preload("res://engine/dungeon/dungeon.gd")
const RollState = preload("res://engine/states/roll_state.gd")
const Checks = preload("res://engine/checks.gd")

# variables
var dicelib
var player1
var player2
var state
var turn = 1

func _init(dungpath=null, pool1path=null, pool2path=null):
    # create dicelib
    dicelib = Dicelib.new()
    # objects for state
    player1 = Player.new(1, dicelib.create_dicepool(pool1path))
    player2 = Player.new(2, dicelib.create_dicepool(pool2path))
    player1.opponent = player2
    player2.opponent = player1
    var dungeon = Dungeon.new()
    # create initial state
    state = RollState.new(player1, player2, dungeon)
    # set init state from file
    set_init_state(dungpath, dungeon)

# public functions
func update(cmddict):
    """
    Update engine with given command.
    """
    # get new state info
    var new_state = state.update(cmddict)
    var state_update = new_state != state
    var next_turn = new_state.player != state.player and new_state.NAME == "ROLL"
    # perform the update
    state = new_state
    if next_turn:
        turn += 1
        Events.emit_signal("next_turn", state.player, turn)
    if state_update:
        Events.emit_signal("state_update", state.NAME)

# private functions
func set_init_state(dungpath, dungeon):
    """
    Set the initial state of the duel, which includes: dungeon layout,
    summons, vortices, crests, and hearts.
    """
    # resolve dungpath is null
    if dungpath == null:
        dungpath = Globals.DUNGPATH
    # get dungpath
    var initdict = Globals.read_jsonfile(dungpath)
    for initkey in initdict:
        match initkey:
            "DUNGEON"  : set_init_dungeon(dungeon, initdict["DUNGEON"])
            "SUMMONS1" : set_init_summons(player1, dungeon, initdict["SUMMONS1"])
            "SUMMONS2" : set_init_summons(player2, dungeon, initdict["SUMMONS2"])
            "VORTEX"   : set_init_vortex(dungeon, initdict["VORTEX"])
            "CRESTS1"  : set_init_crests(player1, initdict["CRESTS1"])
            "CRESTS2"  : set_init_crests(player2, initdict["CRESTS2"])
            "HEARTS1"  : set_init_hearts(player1, initdict["HEARTS1"])
            "HEARTS2"  : set_init_hearts(player2, initdict["HEARTS2"])

func set_init_dungeon(dungeon, dungeon_layout):
    """
    Set initial dungeon layout.
    """
    if Checks.check_dungeon_layout(dungeon_layout):
        dungeon.set_layout(player1, player2, dungeon_layout)

func set_init_summons(player, dungeon, summon_list):
    """
    Set the initial summons in the dungeon.
    """
    for summon_dict in summon_list:
        if Checks.check_summon_dict(summon_dict):
            var pos = str_to_pos(summon_dict["POS"])
            var diceidx = summon_dict["DICE"]-1
            dungeon.place_summon(player, pos, diceidx)
    
func set_init_vortex(dungeon, vortex_list):
    """
    Set the initial vorteces in the dungeon.
    """
    for vortex in vortex_list:
        if Checks.check_pos_string(vortex):
            var pos = str_to_pos(vortex)
            dungeon.place_vortex(pos)

func set_init_crests(player, crests_dict):
    """
    Set the initial crests for player.
    """
    if Checks.check_crests_dict(crests_dict):
        for crest in crests_dict:
            player.crestpool.set_crest(crest, crests_dict[crest])

func set_init_hearts(player, hearts):
    """
    Set initial hearts for player.
    """
    if Checks.check_hearts_int(hearts):
        player.monsterlord.set_hearts(hearts)

func str_to_pos(string):
    """
    Convert string type positioning to vector type.
    """
    return Vector2(string.unicode_at(0)-97, int(string.substr(1))-1)
