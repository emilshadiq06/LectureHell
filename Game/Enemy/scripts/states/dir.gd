class_name Enemy_State_Dir extends Enemy_State
##ref to what this state belongs to

@onready var idle = $"../idle"
var left = Vector2(-1,0)
var right = Vector2(1,0)
var up = Vector2(0,-1)
var down = Vector2(0,1)
var move_list : Array = [left,right,up,down]
var old_dir : Vector2 

func init() -> void:
	pass
#what happens when player enters state
func Enter() ->void:
	
	move_list.erase(enemy.direction)
#	enemy.UpdateAnimation("idle")
	
	pass
	
#what happens when player enters state
func Exit() ->void:
	pass
	
#what happens during process in state
func Process(_delta:float)->Enemy_State:
	enemy.direction = enemy.choose_randomly(move_list)
	if move_list.size() < 2:
		move_list = [left,right,up,down]
	return idle
