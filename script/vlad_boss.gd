extends Area2D

signal vlad_damage(current_health: int)
signal vlad_died

var speed = 300
var movement_points
var current_movement_point

enum PHASE {
	ONE,
	TWO
}

enum Action {
	SPAWN_DEVIL,
	HOMING_SHOT,
	SPRAY_SHOT
}

var phase = PHASE.ONE

@onready var health_system: HealthSystem = $HealthSystem
@onready var shooting_point: Marker2D = $ShootingPoint
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var action_timer: RandomTimer = $ActionTimer


func init():
	var random_point = movement_points.pick_random()
	current_movement_point = random_point.position
	health_system.damaged.connect(on_damaged)
	health_system.died.connect(on_died)
	action_timer.setup()
	
func on_died():
	vlad_died.emit()

func on_damaged(current_health: int):
	vlad_damage.emit(current_health)
	
func get_health():
	return health_system.health
	
	
	
	
	
	
func _process(delta: float) -> void:
	global_position = global_position.move_toward(current_movement_point, delta * speed)
	
	if global_position.distance_squared_to(current_movement_point) < .1:
		current_movement_point = movement_points.pick_random().global_position
	
	
