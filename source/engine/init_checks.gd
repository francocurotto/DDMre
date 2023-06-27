extends Reference

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
        # check correct type for each character
        for tile in row:
            if not tile in "OXlLpPN":
                return false
    # all tests passed
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
    var diceidx_ok = check_diceidx_int(summon_dict["DICE"])
    if not pos_ok or not diceidx_ok:
        return false
    # all tests passed
    return true

static func check_pos_string(pos_str):
    """
    Check if pos string is a valid position in dungeon.
    """
    # check correct type
    if typeof(pos_str) != TYPE_STRING:
        return false
    # check correct length
    if pos_str < 2 or pos_str > 3:
        return false
    # check correct elements in string
    if not pos_str[0] in "abcdefghijklm":
        return false
    if int(pos_str.substr(1)) < 1 or int(pos_str.substr(1)) > 19:
        return false
    # all test passed
    return true

static func check_diceidx_int(diceidx_int):
    """
    Check if int is a valid dice index in 1-indexing (is expected to be 
    transformed to 0-indexing by the engine).
    """
    # check correct type
    if typeof(diceidx_int) != TYPE_INT:
        return false
    # check correct range
    if not diceidx_int in range(1,16):
        return false
    # all test passed
    return true

static func check_crests_dict(crests_dict):
    """
    Check if has a valid format for for crests initializations.
    """
    # check correct type
    if typeof(crests_dict) != TYPE_DICTIONARY:
        return false
    for crest in crests_dict:
        # check valid crest name
        if not crest in Globals.CRESTTYPES:
            return false
        # check correct type for crests count
        if typeof(crests_dict[crest]) != TYPE_INT:
            return false
    # all tests passed
    return true
        
    
