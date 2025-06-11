extends AnimatableBody2D
@export var appear:float = 0
@export var follow:float = 1
@export var damage : int
@export var position_tween : bool
#var rotation
#var last_rotation

var is_alive : bool = true
signal play_hit#$BasicEnemyAttack/Node
@onready var attk_target  = $"../../Player_base"
@onready var anim_player = $AnimatedSprite2D
#var sfx = load("res://Assets/sounds/shot_sound.wav")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.stream = load("res://sounds/hard_kick.mp3")
	$"../../../PlayerGroup".got_duration.connect(got_duration)
	#$"../AudioStreamPlayer".stream =  load("res://Assets/sounds/shot_sound.wav")
	anim_player.play("default")
	anim_player.rotation_degrees += 180
	play_hit.connect(hit_play)
	pass 

func set_target(target):
	return target.position#+target.velocity
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if appear > 0:
		appear -= delta
	else:
		self.show()
		
		#$AudioStreamPlayer.stop()
	if follow > 0:
		follow -= delta
		look_at(attk_target.position)# + attk_target.velocity/50# *delta
		#print(global_position.direction_to(attk_target.global_position).angle())
		#print(rotation)
	else:
		
		#anim_player.stop()
		#await get_tree().create_timer(0.2).timeout
		
		
		modulate.a = 1
		anim_player.play("kick")
		
		
		await get_tree().create_timer(0.35).timeout
		
		#position += Vector2(cos(rotation),sin(rotation)) * sqrt((abs(position-attk_target.position).x)**2 +  (abs(position-attk_target.position).y)**2)
		
		#await get_tree().create_timer(0.05).timeout
		
		
		
		play_hit.emit()
		is_alive = false
		
func hit_play():
	
	if is_alive:
		$AudioStreamPlayer.play()
		await get_tree().create_timer(0.2).timeout

		var tween = get_tree().create_tween().bind_node(self)#.set_trans(Tween.TRANS_ELASTIC)
		
		#tween.tween_property($Sprite2D, "modulate", Color.RED, 0.2)
		var projected_pos = position + Vector2(cos(rotation),sin(rotation)) * sqrt((abs(position-attk_target.position).x)**2 +  (abs(position-attk_target.position).y)**2)
		if !position_tween:
			
			tween.tween_property(self, "scale", Vector2(50.0, 1.0), 0.2)
		else:
			tween.tween_property(self, "position", position + Vector2(cos(rotation),sin(rotation)) * sqrt((abs(position-attk_target.position).x)**2 +  (abs(position-attk_target.position).y)**2)*3, 0.2)
		#tween.tween_property(self, "global_position", (attk_target.global_position - global_position).normalized()*50, 0.2)
		if abs(attk_target.position -projected_pos).x + abs(attk_target.position -projected_pos).y < 60:
			attk_target.take_damage(damage,self)
			
			
		tween.tween_callback(self.queue_free)


func _on_draw() -> void:
	if $AudioStreamPlayer:
		$AudioStreamPlayer.play()
		await get_tree().create_timer(0.55).timeout
		$AudioStreamPlayer.stop()
#	pass # Replace with function body.

func got_duration(duration:float):
	if duration < follow and self and $"../../../PlayerGroup".bullet_hell_timer:

		$"../../../PlayerGroup".bullet_hell_timer.start(follow+1)
#func _on_visibility_changed() -> void:
	#_on_draw()
	#pass # Replace with function body.
