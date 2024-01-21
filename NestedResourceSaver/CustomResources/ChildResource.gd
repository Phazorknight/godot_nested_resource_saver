extends Resource
class_name ChildResource

@export var name : String
@export var value : int

func add_to_value(amount : int):
	value += amount
