extends Area2D
var is_chatting : bool
@export var lines : Array[String]
@export var idler_name: String
# Called when the node enters the scene tree for the first time.
var player
func _ready() -> void:
	if idler_name in StatLoader.dead_array:
		queue_free()
	else:
		monitoring = true
		monitorable = true
func _on_body_entered(body: Node2D) -> void:
	if body is Player and !is_chatting:
		if body.state_machine.current_state != State_Idle:
			body.state_machine.ChangeState(body.state_machine.states[0])
			var tween = get_tree().create_tween()
			
			tween.tween_property(body, "velocity", Vector2.ZERO, 0.05)
			tween.tween_property(body, "velocity", Vector2.ZERO, 1)
	#	if dialogue.quest_name in StatLoader.quest_array:
			#dialogue.index = dialogue.event_index
		DialogueManagerScript.start_dialog(body.global_position, lines)
		is_chatting = true
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		#$DialogueOptions.hide()
		if is_chatting and DialogueManagerScript.is_dialog_active == true:
			DialogueManagerScript.text_box.queue_free()
			DialogueManagerScript.is_dialog_active = false
			DialogueManagerScript.current_line_index = 0
		if idler_name != "":
			StatLoader.dead_array.append(idler_name)
		queue_free()
		is_chatting = false
		player = null
