extends Node
#signal send_result
var index : int = 0
var balls: Array = []
var hitted : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	balls = get_children()
	
	for i in balls.size()-1:
		var displace = choose_randomly([1,1.2,0.8])
		balls[i].position.x = -200*i * displace

	

	

		
func choose_randomly(list_of_entries):
	return list_of_entries[randi() % list_of_entries.size()]


#func _on_area_2d_body_exited(body: Node2D):
	
#	send_result.emit()
#	return hitted
		
