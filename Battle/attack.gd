extends Node2D
signal finish
@onready var hits_result =  $Balls 
var index : int = 0
var hits_reg : int = 0
var has_emit = false
var finished = false

func _process(delta: float) -> void:
	
	if hits_result.index == 3 and has_emit == false:
		print("emitted sybau")
		finish.emit()
		has_emit= true
		

func get_ball_index()-> int:
	index = hits_result.index
	return index
	
func get_ball_hit()-> int:
	hits_reg = hits_result.hitted
	return hits_reg
	
func get_finished()->bool:
	finished = true
	return finished
