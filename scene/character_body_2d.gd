extends CharacterBody2D
@onready var dialogue_player =$Chat
var player
func _ready() -> void:
	DialogueManagerScript.finish_lines.connect(next_line)
	dialogue_player.option_pressed.connect(player_dance)
	if $AudioStreamPlayer != null and dialogue_player.dialogue.quest_name not in StatLoader.quest_array:
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("dance")
func next_line():
	player = dialogue_player.player
		
	if player != null and  dialogue_player.dialogue.index == dialogue_player.lines_array.size()-1:
		if $AudioStreamPlayer != null:
			$AudioStreamPlayer.play()
			$AnimationPlayer.play("dance")
			$AudioStreamPlayer.volume_db = 0
			
	if player != null and  dialogue_player.dialogue.index == dialogue_player.dialogue.event_index:
		if $AudioStreamPlayer != null:
			$AudioStreamPlayer.stop()
			$AnimationPlayer.stop()
			#
			#player.animation_player.play("dance")


func _on_audio_stream_player_finished() -> void:
	if $AudioStreamPlayer != null and dialogue_player.dialogue.quest_name not in StatLoader.quest_array:
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("dance")
	#pass # Replace with function body.

func player_dance():
	if player != null and  dialogue_player.dialogue.index == dialogue_player.dialogue.event_index:
		if $AudioStreamPlayer != null:
			
			$AnimationPlayer.stop()
			#
			player.animation_player.play("dance")
	
