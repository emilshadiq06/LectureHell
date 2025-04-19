extends Control

func _ready() -> void:
	main()

func _on_exit_pressed() -> void:
	$AudioStreamPlayer2D2.play()
	get_tree().quit()


func _on_start_pressed():
	$AudioStreamPlayer2D2.play()
	Function.load_screen_to_scene("res://scene/game.tscn")


func _on_customize_pressed() -> void:
	$AudioStreamPlayer2D2.play()
	custom()
	

func _on_setting_pressed() -> void:
	$AudioStreamPlayer2D2.play()
	settings()
	
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
	
func settings():
	$main.hide()
	$back.show()
	$custom.hide()
	$settings.show()


func _on_back_pressed() -> void:
	main()
