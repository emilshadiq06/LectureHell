class_name Enemy_State extends Node
##ref to what this state belongs to
static var enemy : Enemy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#what happens when player enters state
func Enter() ->void:
	pass
	
#what happens when player enters state
func Exit() ->void:
	pass
	
#what happens during process in state
func Process(_delta:float)->Enemy_State:
	return null

#what happens during physics process in state 
func Physics(_delta:float)->Enemy_State:
	return null
#what happens to inputs event in state
func HandleInput(_event: InputEvent)->Enemy_State:
	return null
