extends AnimatableBody2D
@export var index : int
@export var skate: bool = false
@export var appear:float = 0
@export var follow:float = 2
@export var damage : int
@onready var other_stoves = $"..".get_children()
@onready var markers = $"../Markers"
@export var check_grav:bool
#var last_rotation
var horizontal: bool
var is_alive : bool = true
signal play_hit#$BasicEnemyAttack/Node
@onready var attk_target  = $"../../Player_base"
@onready var warning = $warning
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(markers.get_children())
	warning.play("default")
	var marker_posx =  markers.get_children().pick_random()
	global_position = marker_posx.global_position
	markers.remove_child(marker_posx)
	
	if check_grav:
		if abs($"../gravity".attk_target.grav_from_outside.y) > 0:
			var marker_pos =  $"../Markers2".get_children().pick_random()
			global_position = marker_pos.global_position
			$"../Markers2".remove_child(marker_pos)
			rotation_degrees += 90
			horizontal = true
		
	
	play_hit.connect(hit_play)
	$fire.show()
	$fire.play("fire")
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

		#await get_tree().create_timer(0.05).timeout
		
		
		
		play_hit.emit()
		is_alive = false
		
func hit_play():
	
	if is_alive:
		
		var tween = get_tree().create_tween().bind_node(self)#.set_trans(Tween.TRANS_ELASTIC)
		
		#tween.tween_property($Sprite2D, "modulate", Color.RED, 0.2)
		if !skate:
			tween.tween_property(self, "position",(position + Vector2(cos(rotation-deg_to_rad(90)),sin(rotation-deg_to_rad(90))) * 150), 0.1)
			tween.tween_property(self, "scale", Vector2(1.0, 50.0), 0.2)
		else:
			tween.tween_property(self, "position",(position + Vector2(cos(rotation-deg_to_rad(90)),sin(rotation-deg_to_rad(90))) * 1500), 0.2)
		#tween.tween_property(self, "global_position", (attk_target.global_position - global_position).normalized()*50, 0.2)
		if attk_target.global_position.x <= global_position.x + 80 and attk_target.global_position.x >= global_position.x - 80 and ! horizontal:
			attk_target.take_damage(damage)
		elif attk_target.global_position.y <= global_position.y + 80 and attk_target.global_position.y >= global_position.y - 80  and horizontal:
			attk_target.take_damage(damage)
			#print(rotation - 0.005)
			#print(global_position.direction_to(attk_target.global_position).angle())
			
		tween.tween_callback(self.queue_free)
