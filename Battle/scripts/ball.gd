extends AnimatableBody2D
@onready var balls = $".."
@onready var animated_sprite = $AnimatedSprite
var left = false

var inside = false
var slow = 1
var start_move = false
func choose_randomly(list_of_entries):
	return list_of_entries[randi() % list_of_entries.size()]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	animated_sprite.play("default")
	await get_tree().create_timer(0.2).timeout
	start_move = true
	left = choose_randomly([false,true,false,false])
	animated_sprite.scale.x = -1 if left ==true else 1
	



func _physics_process(delta: float) -> void:
	
	if start_move == true:
		position.x = position.x + 8* slow
	
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("right") and left == false :
		
		if inside:
			
			animated_sprite.play("hit")
			balls.hitted += 1
			
	elif Input.is_action_just_pressed("left") and left == true :
			if inside:
				animated_sprite.play("hit")
				balls.hitted += 1
		



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_method("attack"):
		inside = true
		
		


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.has_method("attack"):
		inside = false
		balls.index += 1
		slow = 0.3
		if animated_sprite.get_animation() == "default" :
			animated_sprite.play("miss")
		
