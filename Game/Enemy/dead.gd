class_name Enemy_State_Dead extends Enemy_State
##ref to what this state belongs to
#@onready var timer = $"../../StateTimer"
#@onready var idle =$"../idle"

func init() -> void:
	pass

#what happens when player enters state
func Enter() ->void:
	set_process(false)
	get_parent().set_process(false)
	get_parent().set_physics_process(false)
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
