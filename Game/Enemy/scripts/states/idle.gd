class_name Enemy_State_Idle extends Enemy_State
##ref to what this state belongs to
@onready var timer = $"../../StateTimer"
@onready var roam =$"../roam"
@onready var chasing =$"../chase"
#what happens when player enters state
func Enter() ->void:
	print("sss")
	timer.start(1.5)
#	enemy.UpdateAnimation("idle")
	pass
	
#what happens when player enters state
func Exit() ->void:
	pass
	
#what happens during process in state
func Process(_delta:float)->Enemy_State:
#	if enemy.direction != Vector2.ZERO:
#		return walk
	enemy.velocity = Vector2.ZERO
	if enemy.chase:
		return chasing
	if timer.get_time_left() <= 0.1:
		print("ok")
		
		return roam
	return null

#what happens during physics process in state 
func Physics(_delta:float)->Enemy_State:
	return null
#what happens to inputs event in state
func HandleInput(_event: InputEvent)->Enemy_State:
	return null
