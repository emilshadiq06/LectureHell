extends AnimatableBody2D
@export var follow:float = 1
@export var damage : int
var is_alive : bool = true
signal play_hit#$BasicEnemyAttack/Node
@onready var attk_target  = $"../../Player_base"
@onready var anim_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("default")
	
	play_hit.connect(hit_play)
	pass 

func set_target(target):
	return target.position#+target.velocity
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if follow > 0:
		follow -= delta
		global_position += (attk_target.global_position - global_position).normalized() *24 # + attk_target.velocity/50# *delta
	else:
		
		await get_tree().create_timer(0.5).timeout
		anim_player.stop()
		anim_player.play("RESET")
		play_hit.emit()
		is_alive = false
		
func hit_play():
	if is_alive and get_parent():
		if abs(attk_target.global_position - global_position).x + abs(attk_target.global_position - global_position).y < 100: #and attk_target.dash_window <= 0.01:
			attk_target.take_damage(damage)
		if get_tree()!= null:
			var tween = get_tree().create_tween()#.set_trans(Tween.TRANS_ELASTIC)
		
			tween.tween_property($Sprite2D, "modulate", Color.RED, 0.2)
			tween.tween_property(self, "scale", Vector2(3.0, 3.0), 0.1)
		#await get_tree().create_timer(0.1).timeout
			tween.tween_callback(self.queue_free)
