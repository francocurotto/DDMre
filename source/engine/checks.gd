extends RefCounted
## Library for checking the validity of IO elements.
##
## The library has a collection of static functions that check the validity of 
## elements extracted from external sources, like JSON files for the 
## initialization of the DDMre engine. 

# constants
const CREST_TYPES = ["SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP"]

## Check if [param dungeon_layout] array has a valid format for dungeon 
## initialization.
static func check_dungeon_layout(dungeon_layout):
    # check correct type
    if typeof(dungeon_layout) != TYPE_ARRAY:
        return false
    # check correct length (dungeon height)
    if len(dungeon_layout) != Globals.DUNGEON_HEIGHT:
        return false
    #check each row in layout
    for row in dungeon_layout:
        # check correct type
        if typeof(row) != TYPE_STRING:
            return false
        # check correct length (dungeon width)
        if len(row) != Globals.DUNGEON_WIDTH:
            return false
    # all checks passed
    return true

## Check if [param summon_dict] dictionary has a valid format for summons 
## initialization.
static func check_summon_dict(summon_dict):
    # check correct type
    if typeof(summon_dict) != TYPE_DICTIONARY:
        return false
    # check if dictionary has the correct keys
    if not "POS" in summon_dict or not "DICE" in summon_dict:
        return false
    # lastly check for the position and dice independently
    var pos_ok = check_pos_string(summon_dict["POS"])
    var diceidx_ok = check_diceidx_float(summon_dict["DICE"])
    if not pos_ok or not diceidx_ok:
        return false
    # all checks passed
    return true

## Check if [param pos_str] string is a valid position in dungeon.
static func check_pos_string(pos_str):
    # check correct type
    if typeof(pos_str) != TYPE_STRING:
        return false
    # check correct length
    if len(pos_str) < 2:
        return false
    # check correct elements in string
    if not pos_str[0] in "abcdefghijklm":
        return false
    var height_str = pos_str.substr(1)
    if not height_str.is_valid_int():
        return false
    if int(height_str) < 1 or int(height_str) > Globals.DUNGEON_HEIGHT:
        return false
    # all checks passed
    return true

## Check if [param diceidx] float is a valid dice index in 1-indexing.
static func check_diceidx_float(diceidx):
    # check correct type
    if typeof(diceidx) != TYPE_FLOAT:
        return false
    # check correct range
    if not diceidx in range(1,Globals.DICEPOOL_SIZE+1):
        return false
    # all checks passed
    return true

## Check if [param crests_dict] dictictionary has a valid format for crests 
## initializations.
static func check_crests_dict(crests_dict):
    # check correct type
    if typeof(crests_dict) != TYPE_DICTIONARY:
        return false
    for crest in crests_dict:
        # check valid crest name
        if not crest in CREST_TYPES:
            return false
        # check correct type for crests count
        if typeof(crests_dict[crest]) != TYPE_FLOAT:
            return false
        # check crest count is int
        if crests_dict[crest]-int(crests_dict[crest]) != 0:
            return false
    # all checks passed
    return true

## Check if [param hearts_num] float has a valid format for hearts 
## initialization.      
static func check_hearts_int(hearts_num):
    # check correct type
    if typeof(hearts_num) != TYPE_FLOAT:
        return false
    # check number has an interger value
    if hearts_num-int(hearts_num) != 0:
        return false
    # check correct value
    if hearts_num < 1 or hearts_num > 3:
        return false
    # all checks passed
    return true
