extends Reference

# constants
const CREST_TYPES = ["SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP"]

static func check_dungeon_layout(dungeon_layout):
    """
    Check if dungeon layout has a valid format for dungeon initialization.
    """
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

static func check_summon_dict(summon_dict):
    """
    Check if summon_dict has a valid format for summons initialization.
    """
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

static func check_pos_string(pos_str):
    """
    Check if pos string is a valid position in dungeon.
    """
    # check correct type
    if typeof(pos_str) != TYPE_STRING:
        return false
    # check correct length
    if len(pos_str) < 2 or len(pos_str) > 3:
        return false
    # check correct elements in string
    if not pos_str[0] in "abcdefghijklm":
        return false
    if int(pos_str.substr(1)) < 1 or int(pos_str.substr(1)) > 19:
        return false
    # all checks passed
    return true

static func check_diceidx_float(diceidx):
    """
    Check if float is a valid dice index in 1-indexing.
    """
    # check correct type
    if typeof(diceidx) != TYPE_REAL:
        return false
    # check correct range
    if not diceidx in range(1,16):
        return false
    # all checks passed
    return true

static func check_diceidx_int(diceidx):
    """
    Check if int is a valid dice index in 0-indexing.
    """
    # check correct type
    if typeof(diceidx) != TYPE_INT:
        return false
    # check correct range
    if not diceidx in range(15):
        return false
    # all checks passed
    return true

static func check_crests_dict(crests_dict):
    """
    Check if dict has a valid format for crests initializations.
    """
    # check correct type
    if typeof(crests_dict) != TYPE_DICTIONARY:
        return false
    for crest in crests_dict:
        # check valid crest name
        if not crest in CREST_TYPES:
            return false
        # check correct type for crests count
        if typeof(crests_dict[crest]) != TYPE_REAL:
            return false
        # check crest count is int
        if crests_dict[crest]-int(crests_dict[crest]) != 0:
            return false
    # all checks passed
    return true
        
static func check_hearts_int(hearts_num):
    """
    Check if number has a valid format for hearts initualization.
    """
    # check correct type
    if typeof(hearts_num) != TYPE_REAL:
        return false
    # check is int
    if hearts_num-int(hearts_num) != 0:
        return false
    # check correct value
    if hearts_num < 1 or hearts_num > 3:
        return false
    # all checks passed
    return true

static func check_repeated_values(array):
    """
    Check if array has repeated values
    """
    var values_list = []
    for value in array:
        if value in values_list:
            return true
        values_list.append(value)
    return false
