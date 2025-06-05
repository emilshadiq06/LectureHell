extends AnimatableBody2D
@export var follow:float = 1
@export var damage : int
var is_alive : bool = true
signal play_hit#$BasicEnemyAttack/Node
@onready var attk_target  = $"../../Player_base"
@onready var anim_player = $AnimationPlayer
@onready var others = $"..".get_children()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../../../PlayerGroup".got_duration.connect(got_duration)
	anim_player.play("default")
	if others.find(self)+1 < others.size():
		look_at(others[(others.find(self)+1)].global_position)
	else:
		look_at(others[0].global_position)
	play_hit.connect(hit_play)
	pass 

#func set_target(target):
	#return target.position#+target.velocity
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if follow > 0:
		
		follow -= delta
		position += (attk_target.position - position + Vector2(cos(rotation + deg_to_rad(90)),sin(rotation++90))*40) /5  # + attk_target.velocity/50# *delta
	else:
		
		await get_tree().create_timer(0.5).timeout
		anim_player.stop()
		anim_player.play("RESET")
		play_hit.emit()
		is_alive = false
		
func hit_play():
	if is_alive and get_parent():
		$AudioStreamPlayer.play()
		if abs(attk_target.global_position - global_position).x + abs(attk_target.global_position - global_position).y < 100: #and attk_target.dash_window <= 0.01:
			attk_target.take_damage(damage)
		if get_tree()!= null:
			var tween = get_tree().create_tween()#.set_trans(Tween.TRANS_ELASTIC)
		
			tween.tween_property($Sprite2D, "modulate", Color.RED, 0.2)
			tween.tween_property(self, "scale", Vector2(3.0, 3.0), 0.1)
			await tween.finished
			
			#await get_tree().create_timer(0.1).timeout
			$AudioStreamPlayer.stop()
			$AudioStreamPlayer.play()
			#await get_tree().create_timer(0.1).timeout
			self.queue_free()
func got_duration(duration:float):
	if duration < follow and self and $"../../../PlayerGroup".bullet_hell_timer:

		$"../../../PlayerGroup".bullet_hell_timer.start(follow+1)
