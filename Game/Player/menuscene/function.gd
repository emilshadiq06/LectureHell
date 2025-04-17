extends Node

func load_screen_to_scene(target: String) -> void:
	var loading_screen = preload("res://Game/Player/menuscene/load.tscn").instantiate()
	loading_screen.next_scene_path = target
	get_tree().current_scene.add_child(loading_screen)
