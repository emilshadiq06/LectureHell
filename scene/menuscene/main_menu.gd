extends Control


func _on_exit_pressed() -> void:
	$AudioStreamPlayer2D2.play()
	get_tree().quit()


func _on_start_pressed():
	$AudioStreamPlayer2D2.play()
	Function.load_screen_to_scene("res://scene/game.tscn")


func _on_customize_pressed() -> void:
	$AudioStreamPlayer2D2.play()
