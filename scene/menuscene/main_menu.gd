extends Control


func _ready() -> void:
	Input.set_custom_mouse_cursor(GlobalSettings.HAND_POINT, Input.CURSOR_POINTING_HAND)
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
	$back.hide()
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
