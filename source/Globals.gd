tool
extends Node

# filepath
const LIBPATH = "res://LIBRARY.json"
const DUNGPATH = "res://dungeons/test.json"
const POOL1PATH = "res://dicepools/test1.json"
const POOL2PATH = "res://dicepools/test2.json"

# arrays, dictionaries
const CRESTS = ["SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP"]
const CRESTCHARS = ["S", "M", "A", "D", "G", "T"]
const CRESTDICT = {"SUMMON"   : "★",
                   "MOVEMENT" : "⬆",
                   "ATTACK"   : "⚔",
                   "DEFENSE"  : "⛨",
                   "MAGIC"    : "✡",
                   "TRAP"     : "⚡"}
const TYPES = ["DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR"]

# IO functions
func str2pos(string):
    return [int(string.substr(1))-1, ord(string[0])-97]
func int2diceidx(integer):
    return integer-1
