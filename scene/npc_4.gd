extends CharacterBody2D

var speed =100
var player_chase = false
var player = null
var direction : Vector2

func _physics_process(delta):
	move_and_slide()
	if player_chase:
		direction = (player.position - position).normalized()
		velocity = direction * speed
		#print(direction)
		print(velocity)
		
		$AnimatedSprite2D.play("walk_e")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false 
	else:
		$AnimatedSprite2D.play("idle")


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	direction = Vector2.ZERO
	velocity = Vector2.ZERO
	player_chase = false
