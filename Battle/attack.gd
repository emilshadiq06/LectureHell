extends Node2D
@onready var hits_result =  $Balls 
var index : int = 0
var hits_reg : int = 0



func get_ball_index()-> int:
	#print(hits_result.index , "wololo")
	index = hits_result.index
	return index
	
func get_ball_hit()-> int:
	#print(hits_result.hitted , "wol")
	hits_reg = hits_result.hitted
	return hits_reg
	


func _on_balls_send_result() -> void:
	get_ball_index()
	get_ball_hit()
	
