class_name Enemy_State_Roam extends Enemy_State
##ref to what this state belongs to
@onready var timer = $"../../StateTimer"
@onready var idle =$"../idle"
@onready var dir = $"../dir"
@onready var chasing =$"../chase"
var result
#what happens when player enters state
func init() -> void:
	pass
	
func Enter() ->void:
	timer.start(2)
#	enemy.UpdateAnimation("idle")
	
	pass
	
#what happens when player enters state
func Exit() ->void:
	pass
	
#what happens during process in state
func Process(_delta:float)->Enemy_State:


	enemy.velocity = enemy.direction * enemy.SPEED
	if enemy.chase:
		return chasing
	if timer.get_time_left() <= 0.1:
		

		return dir
	
	return null
