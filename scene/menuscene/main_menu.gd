extends Control

@onready var brightness: HSlider = $settings/TabContainer/GENERAL/brightness


func _ready() -> void:
	main()


func _on_exit_pressed() -> void:
	$click.play()
	get_tree().quit()


func _on_start_pressed():
	$click.play()
	Function.load_screen_to_scene("res://scene/game.tscn", {"test": "test"})



func _on_customize_pressed() -> void:
	$click.play()
	custom()
	

func _on_setting_pressed() -> void:
	$click.play()
	settings()
	
func _on_back_pressed() -> void:
	main()

func main():
	$main.show()
	$back.hide()
	$custom.hide()
	$settings.hide()
	
func custom():
	$main.hide()
	$back.show()
	$custom.show()
	$settings.hide()
	tween_pop($custom)
	
func settings():
	$main.hide()
	$back.show()
	$custom.hide()
	$settings.show()
	tween_pop($settings)

func tween_pop(panel):
	$zoom.play()
	panel.scale = Vector2(0.85,0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel, "scale", Vector2(1,1), 0.5)


func _on_start_mouse_entered() -> void:
	$hover.play()


func _on_customize_mouse_entered() -> void:
	$hover.play()


func _on_setting_mouse_entered() -> void:
	$hover.play()


func _on_exit_mouse_entered() -> void:
	$hover.play()


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)


func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))


func _on_display_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_brightness_value_changed(value: float) -> void:
	GlobalSettings.update_brightness(value)


	
