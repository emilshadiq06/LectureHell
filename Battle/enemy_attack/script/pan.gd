extends AnimatableBody2D
var negative : bool = false
var move_denominator :float = 1
var time :float = 4
var velocity
signal spawner
var spawn_timer : float =0.2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../../../PlayerGroup".got_duration.connect(got_duration)
	$AudioStreamPlayer.play()
	$AnimatedSprite2D.play("default")
	spawner.connect(spawn)
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn_timer > 0:
		spawn_timer -= delta
	else:
		spawner.emit()
		spawn_timer = 0.5
	var fluxxing = flux(delta)
	velocity = Vector2(10*(fluxxing),0)
	position += Vector2(10*(fluxxing),0)
	#print(velocity)
	pass
func spawn():
	var new_food = get_node("../food").duplicate()
	new_food.position = position
	#[1.25,1].pick_random()
	new_food.velocity+= velocity + Vector2(0,-25)
	new_food.grav = Vector2(0,9.811)
#var velocity #= Vector2(0,-25)
	new_food.velocity*=[0.75,1,1.25].pick_random()
	new_food.velocity.x*=[1,-1].pick_random()
	add_sibling(new_food)
	
	pass
	
func flux(value):
	#if move_denominator > -1:
		
	if move_denominator <= -1:
		move_denominator = -1
		negative = true
	if move_denominator >= 1:
		move_denominator = 1
		negative = false
	if negative:
		move_denominator += value
	else:
		move_denominator -= value
	return move_denominator


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
	pass # Replace with function body.

func got_duration(duration:float):
	if duration < time and self and $"../../../PlayerGroup" != null:

		$"../../../PlayerGroup".bullet_hell_timer.start(time+1)
