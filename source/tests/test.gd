extends Node

func test_func1(arg=null):
    print(arg)

func test_func2(arg:=null):
    print(arg)

func _ready():
        test_func1()    # prints null
        test_func1("a") # prints a
        test_func2()    # prints null
        test_func2("a") # prints null
