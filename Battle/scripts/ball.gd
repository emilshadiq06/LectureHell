extends AnimatableBody2D
@onready var balls = $".."
@onready var animated_sprite = $AnimatedSprite

var long : int
var is_hitted : bool = false
var left = false
var scaler : float
var speed : float = 1
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
	var initial_pos = abs($Area2D.position - position)
	
	if long > 0:
		$Sprite2D.show()
		#print(position)
		

		scaler = long
		#print(scaler)
		#*(scaler-1)
		
		$Sprite2D.scale.x = scaler*1.75
		#$Area2D.scale.x = scaler
		#$Area2D.position.x -= 30*(scaler-1)
		animated_sprite.position.x  += 20
		#$Sprite2D.position.x -= 30*(scaler-1)
		#print($Area2D.position)
		#print(abs(position-$Area2D.position))

	left = choose_randomly([false,true])
	animated_sprite.scale.x = -1 if left ==true else 1
	



func _physics_process(delta: float) -> void:
	
	if start_move == true:
		
		position.x += 24* speed *  slow *3 /(balls.balls.size()+1)
	
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("right") and left == false :
		
		if inside:
			
			animated_sprite.play("hit")
			balls.hitted += 1
			is_hitted = true
			if long>0:
				$Area2D.scale.x = scaler
				$Area2D.position.x -= 30*(scaler-1)
			
	elif Input.is_action_just_pressed("left") and left == true :
		if inside:
			animated_sprite.play("hit")
			balls.hitted += 1
			is_hitted = true
			if long>0:
				$Area2D.scale.x = scaler
				$Area2D.position.x -= 30*(scaler-1)
			
func _process(delta: float) -> void:

		
	if long>0 and is_hitted and inside:
				

		animated_sprite.position.x -= 10* speed *  slow *3 /(balls.balls.size()+1)
		
		if (!Input.is_action_pressed("right") and left == false):

			is_hitted = false
			animated_sprite.play("miss")
			
		if (!Input.is_action_pressed("left") and left == true):

			is_hitted = false
			animated_sprite.play("miss")
			
		


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
		#await get_tree().create_timer(0.5).timeout
		#self.queue_free()
		if long>0 and is_hitted:
			#balls.index += 1
			balls.hitted += 1 + 1 * long/5
		if long>0 and !is_hitted and balls.index <= balls.hitted:
			balls.hitted -= 1 + 1 * long/5
	#print(balls.index," ",balls.hitted)
