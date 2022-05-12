extends Reference

const Dicelib = preload("res://engine/dice/dicelib.gd")
const Player = preload("res://engine/player/player.gd")
const Dungeon = preload("res://engine/dungeon/dungeon.gd")
const RollState = preload("res://engine/states/roll_state.gd")

var dicelib
var player1
var player2
var dungeon
var state

func _init(initpath:=Globals.DUNGPATH, pool1:=Globals.POOL1PATH, pool2:=Globals.POOL2PATH):
    dicelib = Dicelib.new()
    player1 = Player.new(1, dicelib.create_dicepool(pool1))
    player2 = Player.new(2, dicelib.create_dicepool(pool2))
    dungeon = Dungeon.new()
    state = RollState.new(player1, player2)
    set_initstate(initpath)

func update(cmd):
    """
    Update engine with given command.
    """
    state = state.update(cmd)

func set_initstate(initpath):
    var initdict = read_jsoninit(initpath)
    for initkey in initdict:
        match initkey:
            "DUNGEON": dungeon.set_layout(self, initdict["DUNGEON"])
            "SUMMONS1": set_initsummons(player1, initdict["SUMMONS1"])
            "SUMMONS2": set_initsummons(player2, initdict["SUMMONS2"])
            "CREST1": set_initcrests(player1, initdict["CREST1"])
            "CREST2": set_initcrests(player2, initdict["CREST2"])
            "HEARTS1": player1.monsterlord.hearts = initdict["HEARTS1"]
            "HEARTS2": player2.monsterlord.hearts = initdict["HEARTS2"]
            
func set_initcrests(player, crests):
    for crest in crests:
        player.crestpool.slots[crest] = crests[crest]

func set_initsummons(player, summonlist):
    for summondict in summonlist:
        var pos = Globals.str2pos(summondict["POS"])
        var idx = Globals.int2diceidx(summondict["DICE"])
        var summon = player.summon_card(idx)
        dungeon.place_dungobj(pos, summon)

func read_jsoninit(initpath):
    """
    Reads the json that defines the initial state of game.
    """
    var file = File.new()
    file.open(initpath, File.READ)
    var initdict = parse_json(file.get_as_text())
    file.close()
    return initdict
