extends Area2D

class_name Projectile
@onready var sprite_2d: Sprite2D = $Sprite2D

const FRANKIE_PROJECTILE = preload("res://BULLETHELLASSET/Player/frankie_projectile.png")
const HUNTER_PROJECTILE = preload("res://BULLETHELLASSET/Player/hunter_projectile.png")
const WITCH_PROJECTILE = preload("res://BULLETHELLASSET/Player/witch_projectile.png")
const WOLFIE_PROJECTILE = preload("res://BULLETHELLASSET/Player/wolfie_projectile.png")

var speed = 500
var projectile_prefix

func _ready() -> void:
	match projectile_prefix:
		"Haruni":
			sprite_2d.texture = FRANKIE_PROJECTILE
		"Ipang":
			sprite_2d.texture = HUNTER_PROJECTILE
		"Milo":
			sprite_2d.texture = WITCH_PROJECTILE
		"Arzim":
			sprite_2d.texture = FRANKIE_PROJECTILE
			
func _process(delta):
	position += Vector2.RIGHT * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
