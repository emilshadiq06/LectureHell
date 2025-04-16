class_name State_Walk extends State
##ref to what this state belongs to
@export var move_speed: float = 100.0

@onready var idle : State = $"../idle"
@onready var running: State = $"../running"


#what happens when player enters state
func Enter() ->void:
	player.UpdateAnimation("walk")
	pass
	
#what happens when player enters state
func Exit() ->void:
	pass
	
#what happens during process in state
func Process(_delta:float)->State:
	if player.direction == Vector2.ZERO:
		
		return idle
	if player.run == 2:
		
		return running
		
	player.velocity = player.direction * move_speed
	

	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null

#what happens during physics process in state 
func Physics(_delta:float)->State:
	return null
#what happens to inputs event in state
func HandleInput(_event: InputEvent)->State:
	
	return null
