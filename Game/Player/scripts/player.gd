
class_name Player extends CharacterBody2D

const DOUBLETAP_DELAY = .30
var doubletap_time = DOUBLETAP_DELAY
var last_keycode = 0

var direction : Vector2 = Vector2.ZERO
var cardinal_direction : Vector2 = Vector2.DOWN
var run: int = 1
@onready var skill = $skill
@onready var stats = $stats
@onready var animation_player : AnimationPlayer= $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if StatLoader.hp == 0:
		StatLoader.get_stats_player(get_stats())
	else:
		stats.update_stats()
	if StatLoader.skill_node != null:
		skill.set_script(StatLoader.return_skill().get_script())
		#StatLoader.skill_node = null
	state_machine.initialize(self)
	if StatLoader.was_just_inBattle == true:
		StatLoader.was_just_inBattle = false
		stats.money = StatLoader.money
		print("KKKKKKKKKKKKKK")
		print(stats.money)
		
		global_position = StatLoader.previous_position
	
	pass # Replace with function body.






# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	doubletap_time -= delta
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down")).normalized()

	pass
	
func _input(event: InputEvent):
	if Input.is_action_just_pressed("left")||Input.is_action_just_pressed("right")||Input.is_action_just_pressed("up")||Input.is_action_just_pressed("down") :
		
		if last_keycode == event.keycode and  doubletap_time >= 0 and doubletap_time < 0.2: 
			
			last_keycode = 0
			run = 2
	

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
	
func get_stats():

	var hp = stats.hp
	var weapon = stats.weapon
	var pp = stats.pp
	var money = stats.money
	var inventory = stats.inventory
	return [hp,weapon,pp,money,inventory]
	
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
