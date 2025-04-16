class_name State_Idle extends State
##ref to what this state belongs to
@onready var walk : State = $"../walk"



#what happens when player enters state
func Enter() ->void:
	player.UpdateAnimation("idle")
	pass
	
#what happens when player enters state
func Exit() ->void:
	pass
	
#what happens during process in state
func Process(_delta:float)->State:

	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	player.run = 1
	
	return null

#what happens during physics process in state 
func Physics(_delta:float)->State:
	return null
#what happens to inputs event in state
func HandleInput(_event: InputEvent)->State:
	return null
