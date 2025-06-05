extends AnimatableBody2D
@export var damage : int
var grav = Vector2(0,0)
var velocity = Vector2(0,0)
var attk_target
var is_alive : bool= true
signal play_hit
# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	$AudioStreamPlayer.play()
	play_hit.connect(hit_play)
	attk_target = $"../../Player_base"
	$AnimatedSprite2D.play("default")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity += grav*delta*1.2
	position += velocity
	if velocity.y == 50:
		self.queue_free()
	if abs(attk_target.global_position - global_position).x + abs(attk_target.global_position - global_position).y < 30:
			play_hit.emit()
			#print("smi")
			is_alive = false
func hit_play():
	if is_alive and get_parent():
		
		attk_target.take_damage(damage)
		self.queue_free()


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
	pass # Replace with function body.
