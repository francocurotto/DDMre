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
var turn = 1

func _init(initpath, random_pool:=true, pool1:=null, pool2:=null):
    # duel objects
    dicelib = Dicelib.new()
    if random_pool:
        player1 = Player.new(1, dicelib.create_randpool())
        player2 = Player.new(2, dicelib.create_randpool())
    else:
        print(initpath)
        print(pool1)
        print(pool2)
        player1 = Player.new(1, dicelib.create_dicepool(pool1))
        player2 = Player.new(2, dicelib.create_dicepool(pool2))
    add_opponent_reference()
    dungeon = Dungeon.new()
    state = RollState.new(player1, player2, dungeon)
    # connections
    for dice in player1.dicepool:
        dice.connect("rolled", player1.crestpool, "add_rolled_side")
    for dice in player2.dicepool:
        dice.connect("rolled", player2.crestpool, "add_rolled_side")
    player1.connect("summon_dead", dungeon, "on_summon_dead")
    player2.connect("summon_dead", dungeon, "on_summon_dead")
    # set init state from file
    set_initstate(initpath)

# public functions
func update(cmd):
    """
    Update engine with given command.
    """
    # get new state info
    var newstate = state.update(cmd)
    var state_update = newstate != state
    var next_turn = newstate.player != state.player and newstate.NAME == "ROLL"
    # perform the update
    state = newstate
    if next_turn:
        turn += 1
        Events.emit_signal("next_turn", state.player, turn)
    if state_update:
        Events.emit_signal("state_update", state.NAME)

# private functions
func add_opponent_reference():
    """
    Add opponent reference to players.
    """
    player1.opponent = player2
    player2.opponent = player1
    
func set_initstate(initpath):
    """
    Set the initial state of the duel, which includes: dungeon layout,
    summons, crests, and hearts.
    """
    var initdict = Globals.read_jsonfile(initpath)
    for initkey in initdict:
        match initkey:
            "DUNGEON"  : dungeon.set_layout(self, initdict["DUNGEON"])
            "SUMMONS1" : set_initsummons(player1, initdict["SUMMONS1"])
            "SUMMONS2" : set_initsummons(player2, initdict["SUMMONS2"])
            "VORTEX"   : set_initvortex(initdict["VORTEX"])
            "CRESTS1"  : set_initcrests(player1, initdict["CRESTS1"])
            "CRESTS2"  : set_initcrests(player2, initdict["CRESTS2"])
            "HEARTS1"  : player1.monsterlord.hearts = initdict["HEARTS1"]
            "HEARTS2"  : player2.monsterlord.hearts = initdict["HEARTS2"]

func set_initsummons(player, summonlist):
    """
    Set the initial summons in the dungeon.
    """
    for summondict in summonlist:
        var pos = str_to_pos(summondict["POS"])
        var idx = summondict["DICE"] - 1 # convert to zero indexing
        var summon = player.summon_card(idx)
        dungeon.array[pos.y][pos.x].set_content(summon)
        summon.initialize_abilities(dungeon)
    
func set_initvortex(vortexlist):
    """
    Set the initial vorteces in the dungeon.
    """
    for vortex in vortexlist:
        var pos = str_to_pos(vortex)
        var tile = dungeon.array[pos.y][pos.x]
        if tile.is_path():
            tile.vortex = true

func set_initcrests(player, crests):
    """
    Set the initial crests for player.
    """
    for crest in crests:
        player.crestpool.slots[crest] = crests[crest]

func str_to_pos(string):
    """
    Convert string type positioning to vector type.
    """
    return Vector2(ord(string[0])-97, int(string.substr(1))-1)
