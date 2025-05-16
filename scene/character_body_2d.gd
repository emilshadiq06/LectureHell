extends CharacterBody2D

# Define the NPC's properties
var speed = 100
var direction = Vector2.ZERO
var target_position = Vector2.ZERO
var is_chatting : bool = false
const lines: Array[String] = [
	"Go to green hat guy!! "
	
	
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
		is_chatting = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_node("../Player") :
		if is_chatting and DialogueManagerScript.is_dialog_active == true:
			DialogueManagerScript.text_box.queue_free()
			DialogueManagerScript.is_dialog_active = false
			DialogueManagerScript.current_line_index = 0
		is_chatting = false
		
		
