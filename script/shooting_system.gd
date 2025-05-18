extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"



const PROJECTILE = preload("res://scene/projectile.tscn")

var animation_prefix
var can_shoot = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") && can_shoot:
		shoot()
		can_shoot = true
		
func shoot():
	var projectile = PROJECTILE.instantiate()
	projectile.global_position = global_position
	projectile.projectile_prefix = animation_prefix
	print("shooting animation: %s" % animation_prefix)
	animated_sprite_2d.play("%s_shooting" % animation_prefix)
	get_tree().root.add_child(projectile)
	


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "%s_shooting" % animation_prefix:
		animated_sprite_2d.play("%s_default" % animation_prefix)
		can_shoot = true
