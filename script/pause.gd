extends Control

@onready var canvas = $".." # The pause menu container (e.g., PanelContainer)
@onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("RESET")
	hide()
	$settings.hide() # hides the settings menu on start


func pause_game():
	get_tree().paused = true
	show()
	anim_player.play("blur")

func resume_game():
	get_tree().paused = false
	anim_player.play_backwards("blur")
	await anim_player.animation_finished
	hide()

func _process(_delta):
	# ESC toggles pause
	if Input.is_action_just_pressed("pause"):
		if !get_tree().paused:
			pause_game()
		else:
			resume_game()

	# SPACE only resumes (does NOT open the menu)
	elif Input.is_action_just_pressed("ui_accept"):
		if get_tree().paused:
			resume_game()


func _on_button_2_pressed() -> void:
	$settings.show()

func _on_button_pressed() -> void:
	if get_tree().paused:
		resume_game()
		

func _on_backsetting_pressed() -> void:
	$settings.hide()
	show() # return to pause menu


func _on_button_3_pressed() -> void:
	get_tree().quit()
