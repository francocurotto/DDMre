extends Reference

# preloads
const Dicelib = preload("res://engine/dice/dicelib.gd")
const Player = preload("res://engine/player/player.gd")
const Dungeon = preload("res://engine/dungeon/dungeon.gd")
const RollState = preload("res://engine/states/roll_state.gd")

# variables
var dicelib
var player1
var player2
var dungeon
var state
var messager

# signals
signal state_update(state_name)
signal next_turn

func _init(initpath:=Globals.DUNGPATH, pool1:=Globals.POOL1PATH, pool2:=Globals.POOL2PATH):
    # duel objects
    dicelib = Dicelib.new()
    player1 = Player.new(1, dicelib.create_dicepool(pool1))
    player2 = Player.new(2, dicelib.create_dicepool(pool2))
    dungeon = Dungeon.new()
    state = RollState.new(player1, player2)
    set_initstate(initpath)
    # connections
    for dice in player1.dicepool:
        dice.connect("rolled", player1.crestpool, "add_crests")
    for dice in player2.dicepool:
        dice.connect("rolled", player2.crestpool, "add_crests")

# public functions
func update(cmd):
    """
    Update engine with given command.
    """
    # get new state info
    var newstate = state.update(cmd)
    var state_update = newstate != state
    var next_turn = newstate.is_other_turn(state)
    # perform the update
    state = newstate
    if state_update:
        emit_signal("state_update", state.NAME)
    if next_turn:
        emit_signal("next_turn")

# private functions
func set_initstate(initpath):
    """
    Set the initial state of the duel, which includes: dungeon layout,
    summons, crests, and hearts.
    """
    var initdict = read_jsoninit(initpath)
    for initkey in initdict:
        match initkey:
            "DUNGEON" : dungeon.set_layout(self, initdict["DUNGEON"])
            "SUMMONS1": set_initsummons(player1, initdict["SUMMONS1"])
            "SUMMONS2": set_initsummons(player2, initdict["SUMMONS2"])
            "CRESTS1" : set_initcrests(player1, initdict["CRESTS1"])
            "CRESTS2" : set_initcrests(player2, initdict["CRESTS2"])
            "HEARTS1" : player1.monsterlord.hearts = initdict["HEARTS1"]
            "HEARTS2" : player2.monsterlord.hearts = initdict["HEARTS2"]

func read_jsoninit(initpath):
    """
    Reads the json that defines the initial state of game.
    """
    var file = File.new()
    file.open(initpath, File.READ)
    var initdict = parse_json(file.get_as_text())
    file.close()
    return initdict

func set_initsummons(player, summonlist):
    """
    Set the initial summons in the dungeon.
    """
    for summondict in summonlist:
        var pos = Globals.str2pos(summondict["POS"])
        var idx = Globals.int2diceidx(summondict["DICE"])
        var summon = player.summon_card(idx)
        dungeon.place_dungobj(pos, summon)
           
func set_initcrests(player, crests):
    """
    Set the initial crests for player.
    """
    for crest in crests:
        player.crestpool.slots[crest] = crests[crest]
