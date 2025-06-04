extends Node
signal send_result

var index : int = 0
var balls: Array = []
var hitted : int = 0
var newball
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await get_tree().create_timer(0.1).timeout
	balls = get_children()
	
	
	
	for i in range(balls.size()):
		var displace = choose_randomly([0,0.5,0.75])

			#print("nigger")
		balls[i].position += Vector2(200 + (-300 * (i)) +( -300 * displace),50*(i))
			#balls[i].position.x = 200 + (-300 * (i)) +( -300 * displace)
		
		

	
func add_ball(ball_added: Array,crit:bool):
	if crit:
		get_node("Ball2").long = ball_added[0][0]

	for i in range(ball_added.size()-1):
		newball = get_node("Ball2").duplicate()
		if crit:
			newball.long = ball_added[i+1][0]
		
		add_child(newball)
func ball_speed(speed:Array):
	balls = get_children()
	for i in range(balls.size()):
		balls[i].speed = speed[i][1]
		#print("here")
		#print(i.speed)
		
func choose_randomly(list_of_entries):
	return list_of_entries[randi() % list_of_entries.size()]


#func _on_area_2d_body_exited(body: Node2D):
	
#	send_result.emit()
#	return hitted
		
#func _process(delta: float) -> void:
	
#	if index >= balls.size():
	#	send_result.emit()
		#sent = true
		
		

		
