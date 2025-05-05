extends Node
#signal send_result

var index : int = 0
var balls: Array = []
var hitted : int = 0
var newball
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	balls = get_children()
	await get_tree().create_timer(0.1).timeout
	
	
	for i in balls.size()-1:
		var displace = choose_randomly([2,1.5,0.4])
		balls[i].position.x = -150 +( -200* i * displace)

	
func add_ball(ball_added: int):
	for i in ball_added:
		newball = get_node("Ball2").duplicate()

		add_child(newball)

		
func choose_randomly(list_of_entries):
	return list_of_entries[randi() % list_of_entries.size()]


#func _on_area_2d_body_exited(body: Node2D):
	
#	send_result.emit()
#	return hitted
		
