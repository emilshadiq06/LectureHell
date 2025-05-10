extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()


func _on_button_pressed() -> void:
	resume()


func _on_button_3_pressed() -> void:
	get_tree().quit()
	
	
func _process(_delta):
	testEsc()


func _on_button_2_pressed() -> void:
	$settings.show()


func _on_backsetting_pressed() -> void:
	$settings.hide()
