extends Area2D

class_name Character



@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@export var speed = 500
var direction

var animation_prefix


func _process(delta: float) -> void:
	animation_prefix = GameConfigBullet.PlayerType.keys()[GameConfigBullet.player_type].to_snake_case()
	animated_sprite_2d.play("%s_default" % animation_prefix)
	var next_position = position + direction * speed * delta
	if !is_within_screen_bounds(next_position):
		return
	position = next_position

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("down"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("right"):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO
		
func is_within_screen_bounds(next_position: Vector2):
	var half_size = collision_shape_2d.shape.get_rect().size / 2
	
	var viewport_size = get_viewport_rect().size
	
	if next_position.y > half_size.y && next_position.y + half_size.y < viewport_size.y && next_position.x > half_size.x && next_position.x + half_size.x < viewport_size.x:
		return true
	
	return false
	
		
	
