extends Control


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed():
	Function.load_screen_to_scene("res://Game/game.tscn")
