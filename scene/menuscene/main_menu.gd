extends Control

@onready var brightness: HSlider = $settings/TabContainer/GENERAL/brightness
@onready var input_button_scene = preload("res://input_button.tscn")
@onready var action_list: VBoxContainer = $settings/TabContainer/CONTROL/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remapping = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"up": "Move Up",
	"left": "Move Left",
	"right": "Move Right",
	"down": "Move Down",
	"advance_dialog": "Dialogue",
	
}


func _ready() -> void:
	main()
	_create_action_list()

func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text  = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
			
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		
func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press Key to bind..."

func _input(event):
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()
			
func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")

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


func _on_reset_button_pressed() -> void:
	_create_action_list()
