extends AnimatableBody2D
@export var index : int
@export var appear:float = 0
@export var follow:float = 2
@export var damage : int
@onready var other_stoves = $"..".get_children()
@onready var markers = $"../Markers".get_children()
#var rotation
#var last_rotation
var is_alive : bool = true
signal play_hit#$BasicEnemyAttack/Node
@onready var attk_target  = $"../../Player_base"
@onready var warning = $warning
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	warning.play("default")
	global_position.x = markers.pick_random().global_position.x
	
	play_hit.connect(hit_play)
	#for i in markers:d
		
	
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if appear > 0:
		appear -= delta
	else:
		self.show()
	if follow > 0:
		follow -= delta
		#look_at(attk_target.position)# + attk_target.velocity/50# *delta
		#print(global_position.direction_to(attk_target.global_position).angle())
		#print(rotation)
	else:
		
		warning.hide()
		#await get_tree().create_timer(0.2).timeout
		
		await get_tree().create_timer(0.3).timeout
		$fire.show()
		$fire.play("fire")
		await get_tree().create_timer(0.05).timeout
		
		
		
		play_hit.emit()
		is_alive = false
		
func hit_play():
	
	if is_alive:
		
		var tween = get_tree().create_tween().bind_node(self)#.set_trans(Tween.TRANS_ELASTIC)
		
		#tween.tween_property($Sprite2D, "modulate", Color.RED, 0.2)
		
		tween.tween_property(self, "scale", Vector2(1.0, 50.0), 0.2)
		#tween.tween_property(self, "global_position", (attk_target.global_position - global_position).normalized()*50, 0.2)
		if attk_target.global_position.x <= global_position.x + 100 and attk_target.global_position.x >= global_position.x - 100 and attk_target.dash_window <= 0.01:
			attk_target.take_damage(damage)
			#print(rotation + 0.005)
			#print(rotation - 0.005)
			#print(global_position.direction_to(attk_target.global_position).angle())
			
		tween.tween_callback(self.queue_free)
