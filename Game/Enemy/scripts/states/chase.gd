class_name Enemy_State_Chase extends Enemy_State
##ref to what this state belongs to
@onready var timer = $"../../StateTimer"
@onready var idle =$"../idle"

#what happens when player enters state
func Enter() ->void:
	timer.start(10)
	await get_tree().create_timer(1).timeout
#	enemy.UpdateAnimation("idle")
	pass
	
#what happens when player enters state
func Exit() ->void:
	pass
	
#what happens during process in state
func Process(_delta:float)->Enemy_State:
	
	enemy.velocity = enemy.chase_dir * enemy.SPEED * 1.5
	
	if timer.get_time_left() <= 0.1:
		enemy.chase = false
		print("ok")
		
		return idle
	return null

#what happens during physics process in state 
func Physics(_delta:float)->Enemy_State:
	return null
#what happens to inputs event in state
func HandleInput(_event: InputEvent)->Enemy_State:
	return null
