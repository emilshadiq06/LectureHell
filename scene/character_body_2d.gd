extends CharacterBody2D

# Define the NPC's properties
var speed = 100
var direction = Vector2.ZERO
var target_position = Vector2.ZERO

const lines: Array[String] = [
	"Welcome Player!!"
	
	
]

# Node paths
@onready var sprite = $Sprite2D
@onready var collision = $ABU

func _ready():
	# Set the initial target position (or you could move it based on game logic)
	target_position = position


func _process(_delta):
	# Move the NPC towards a target position or implement AI logic to control movement
	#direction = (target_position - position).normalized()
	#move_and_slide()
	pass

func set_target_position(new_position):
	# Method to update the target position for the NPC
	target_position = new_position




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_node("../Player") :
		
		DialogueManagerScript.start_dialog(global_position, lines)
