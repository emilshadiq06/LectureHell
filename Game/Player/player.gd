class_name Player extends CharacterBody2D
var dashes : int = 4
const DOUBLETAP_DELAY = .30
var doubletap_time = DOUBLETAP_DELAY
var last_keycode = 0

var direction : Vector2 = Vector2.ZERO
var cardinal_direction : Vector2 = Vector2.DOWN
var run: int = 1
var dashing:bool = false
var dash_cooldown : float
var dash_window :float
@export var play_dash: bool = true
@export var dash_window_duration : float
@onready var animation_player : AnimationPlayer= $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

func _ready() -> void:
	#dash_window=$dash_window
	#dash_cooldown=$dash_cooldown
	#dashes = 4
	state_machine.initialize(self)

	pass # Replace with function body.






# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dash_cooldown<= 0 and dashes < 4:
		#dash_cooldown.stop()
		dashes +=1
		dash_cooldown = 1.5
	doubletap_time -= delta
	if dash_cooldown> 0:
		dash_cooldown -= delta
	if dash_window> 0:
		dash_window -= delta
	direction = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down")).normalized()
	if dash_window > 0 and dashing:
		direction*=2
		#current_anim = animation_player.current_animation
		if play_dash:
			animation_player.play("dash")
	elif dash_window <= 0:
		sprite.modulate.a = 1
		direction.normalized()
		dashing =  false
		dash_window=0
	pass
	
func _input(event: InputEvent):
	if Input.is_action_just_pressed("left")||Input.is_action_just_pressed("right")||Input.is_action_just_pressed("up")||Input.is_action_just_pressed("down") :
		
		if last_keycode == event.keycode and  doubletap_time >= 0 and doubletap_time < 0.2: 
			
			last_keycode = 0
			run = 2
			if dashes>0 and dash_window==0:
				dash_window= (dash_window_duration)
				dash_cooldown=1.25
				dashes -= 1
				dashing = true
		else:
			last_keycode = event.keycode
		
		doubletap_time = DOUBLETAP_DELAY

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:

		return false
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	if new_dir == cardinal_direction:
		return false
	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func UpdateAnimation(state : String) -> void:
	animation_player.play(state + "_" + AnimDirect())
	pass
	
func AnimDirect() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func take_damage(damage):
	if dash_window <= 0:
		for i in $"../../PlayerGroup".players:
		#await get_tree().create_timer(0.02).timeout
			dash_window = 0.5

			i.take_damage(damage*$"../../PlayerGroup".in_damage_multiplier)
			animation_player.play("dash")
			await get_tree().create_timer(animation_player.current_animation_length-0.2).timeout

			animation_player.play("dash")
			await get_tree().create_timer(animation_player.current_animation_length-0.2).timeout
			
			animation_player.play("dash")
			await get_tree().create_timer(animation_player.current_animation_length-0.2).timeout
			animation_player.play("dash")
			animation_player.stop()
			
			#await get_tree().create_timer(animation_player.current_animation_length-0.2).timeout
			#modulate.a = 1
			
			#await get_tree().create_timer(animation_player.current_animation_length-0.2).timeout
