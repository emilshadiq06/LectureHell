class_name Enemy extends CharacterBody2D
@onready var player = get_node("../Player")
@onready var fight = preload("res://Battle/battle.tscn").instantiate()
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const SPEED = 150.0



func _physics_process(delta: float) -> void:
	velocity = (player.position - position).normalized() * SPEED
	

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		print("p")
		var current_scene = get_tree().current_scene
		get_tree().get_root().add_child(fight)
		get_tree().current_scene = fight
		current_scene.queue_free()
