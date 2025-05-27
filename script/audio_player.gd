extends Node

func play_audio(audio:String):
	var sfx = load(audio)
	var new_audio_player = AudioStreamPlayer2D.new()
	add_sibling(new_audio_player)
	new_audio_player.stream = sfx
	new_audio_player.play()
	if new_audio_player.finished:
		await get_tree().create_timer(new_audio_player.stream.get_length()).timeout
		new_audio_player.queue_free()
	#await get_tree().create_timer(3).timeout
	#print(new_audio_player)


		
