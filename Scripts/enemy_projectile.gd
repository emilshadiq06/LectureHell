extends Area2D

class_name EnemyProjectile

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D


enum ProjectilePattern {
	LINEAR,
	SIN,
	ACOS,
	ACOSH,
	TANH,
	VLAD
}

@export_group("shooting params")
var pattern: ProjectilePattern = ProjectilePattern.SIN
var horizontal_speed = 400
var amplitude = 4
var y_direction = -1

func set_projectile_texture(projectile_texture):
	sprite_2d.texture = projectile_texture
	
func set_vlad_pattern():
	pattern = ProjectilePattern.VLAD
func _ready() -> void:
#	if  get_tree().current_scene and get_tree().current_scene.scene_file_path =="res://scene/hallway.tscn":
	#	self.queue_free()
	if  get_tree().current_scene == null:
		self.queue_free()
func _process(delta):
	if  get_tree().current_scene == null:
		self.queue_free()
	var x = global_position.x - delta * horizontal_speed	
	var y = global_position.y + get_vertical_position(x, delta)
	
	position = Vector2(x, y)
	

func get_vertical_position(x_position: float, delta: float):
	match pattern:
		ProjectilePattern.SIN:
			return sin(delta * x_position * PI * 2 / amplitude)
		ProjectilePattern.ACOS:
			return acos(delta * x_position * PI * 2 / amplitude ) * y_direction
		ProjectilePattern.ACOSH:
			return acosh(delta * x_position * PI * 2 / amplitude) * y_direction
		ProjectilePattern.TANH:
			return tanh(delta * x_position * PI * 2 / amplitude)
		ProjectilePattern.VLAD:
			return x_position * tan(rotation) * delta
		ProjectilePattern.LINEAR:
			return 0
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Projectile or area is PlayerB:
		queue_free()
	
	if area is Projectile:
		area.queue_free()


	


func _on_tree_exited() -> void:

	if self != null:
		self.queue_free()
	pass


func _on_tree_entered() -> void:

	var scene
	if  get_tree().current_scene:
		scene = get_tree().current_scene.scene_file_path 
	else:
		self.queue_free()
	if scene =="res://scene/hallway.tscn":
		self.queue_free()
	elif scene == null:
		self.queue_free()
	pass # Replace with function body.
