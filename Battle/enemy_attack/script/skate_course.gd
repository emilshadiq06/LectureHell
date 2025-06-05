extends Area2D
@export var damage : int
var is_alive : bool = true
@export var release_time : float 
var time :float = 10
@onready  var platforms = $"../AnimatableBody2D"
@onready var rotation_marker = $"../Marker2D"
signal play_hit
@onready var attk_target  = $"../../Player_base"
var move : Vector2 = Vector2(3,0)
func _ready() -> void:
	
	var distance: float = abs(global_position - rotation_marker.global_position).x
	#$Sprite2D.modulate = Color("red")
	$"../AudioStreamPlayer".stream = load("res://sounds/hard_kick.mp3")
	
	if $"../gravity".attk_target.grav_from_outside.y<0:
		move *= -1
		
		rotation_marker.rotation_degrees += 180
		rotation_degrees += 180
		
	elif  $"../gravity".attk_target.grav_from_outside.x<0:
		
		move = Vector2(move.y,move.x)
		
		
		rotation_marker.rotation_degrees += 90
		rotation_degrees += 90
	elif  $"../gravity".attk_target.grav_from_outside.x>0:
		
		move = Vector2(move.y,move.x)*-1
		
		rotation_marker.rotation_degrees -= 90
		rotation_degrees -= 90
		
	global_position = rotation_marker.global_position + (Vector2(cos(rotation_marker.rotation),sin(rotation_marker.rotation)) * -(distance))
	platforms.global_position = global_position
	platforms.global_rotation = global_rotation
	play_hit.connect(hit_play)
	$"../AudioStreamPlayer".play()
	#print(platforms.rotation_degrees)
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if time > 0:
	time -= delta
	#rotation_degrees += 3
	if time < release_time and time > 0:
		position += move
		platforms.global_position = global_position
		#$"../AudioStreamPlayer".play()
	if time < -1:
		self.queue_free()
		
		
		
		
func hit_play():
	#print("kkkkkk")
	if is_alive:
		
		var tween = get_tree().create_tween().bind_node(self)#.set_trans(Tween.TRANS_ELASTIC)
		
		
		#if attk_target.dash_window <= 0.01:
		attk_target.dash_window = 0
		attk_target.take_damage(damage)
			
			
		#tween.tween_callback(self.queue_free)

func _on_body_entered(body: Node2D) -> void:
	play_hit.emit()
	#is_alive = false
	pass # Replace with function body.


func _on_audio_stream_player_finished() -> void:
	
	$"../AudioStreamPlayer".play()
	var abu = $"../AudioStreamPlayer"
	
	pass # Replace with function body.
