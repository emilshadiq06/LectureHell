class_name Enemy extends CharacterBody2D
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var state_machine  = $EnemyStateMachine
@onready var player = get_node("../Player")
@export var stats : stat
@export var group_str: String
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

const SPEED = 100.0
var chase_dir : Vector2
var chase : bool = false 

func _ready() -> void:
	state_machine.initialize(self)
	#direction.y = 1
	pass # Replace with function body.

func _process(delta: float) -> void:
	if chase == true:
		chase_dir = (player.position-position).normalized()
	pass
	
func _physics_process(delta: float) -> void:

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
		#print(cardinal_direction)
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

func choose_randomly(list_of_entries):
	return list_of_entries[randi() % list_of_entries.size()]
	

		

func _on_chase_area_body_entered(body) -> void:
	if body == player:
		chase = true
