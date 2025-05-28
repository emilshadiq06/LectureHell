class_name Player extends CharacterBody2D

const DOUBLETAP_DELAY = .30
var doubletap_time = DOUBLETAP_DELAY
var last_keycode = 0

var direction : Vector2 = Vector2.ZERO
var cardinal_direction : Vector2 = Vector2.DOWN
#@onready var player_team = $inventory/player_team_ui
var run: int = 1
#@export var inv :Inv
#@onready var skill = $skill
#@onready var stats = $stats
var dash_cooldown 
var dash_window 
@onready var animation_player : AnimationPlayer= $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
#@export var stats : playerStat
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dash_window=$dash_window
	dash_cooldown=$dash_cooldown

	state_machine.initialize(self)

	pass # Replace with function body.






# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Label:
		$Label.text = str(dash_cooldown.get_time_left())
	#print(dash_cooldown.get_time_left())
	if dash_window.get_time_left()  < 0.01 and run == 2:
		direction = Vector2.ZERO
		velocity = Vector2.ZERO
		state_machine.current_state = $StateMachine/walk
		run = 1
		dash_window.stop()

		#print(dash_window.time_left)
		
		#dash_cooldown.start(3)
	if dash_cooldown.get_time_left()  < 0.1:
		dash_cooldown.stop()
	doubletap_time -= delta
	direction = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down")).normalized()
	#print(state_machine.current_state.name)
	pass
	
func _input(event: InputEvent):
	if Input.is_action_just_pressed("left")||Input.is_action_just_pressed("right")||Input.is_action_just_pressed("up")||Input.is_action_just_pressed("down") :
		
		if last_keycode == event.keycode and  doubletap_time >= 0 and doubletap_time < 0.2: 
			#print(dash_cooldown.get_time_left())
			print(last_keycode)
			last_keycode = 0
			print(last_keycode)
			if dash_cooldown.get_time_left() < 0.1 and run == 1:
				
				run = 2
				#print(run)
				dash_window.start(0.3)
				dash_cooldown.start(3)

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
	
