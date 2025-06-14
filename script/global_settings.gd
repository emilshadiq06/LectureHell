extends Node
const SAVE_PATH = "user://settings.cfg"

signal brightness_updated(value)
signal bloom_toggled(value)
signal selected_character_changed

const HAND_POINT = preload("res://character/Light/Hands/Hand3.png")

var selected_character = 0
const characters = [
	preload("res://Game/Player/sprites/ExamplePlayerSprite1.png"),
	preload("res://Game/Player/sprites/ExamplePlayerSprite3.png"),
	preload("res://Game/Player/sprites/ExamplePlayerSprite2.png"),
	preload("res://Game/Player/sprites/ExamplePlayerSprite.png")
]


var brightness := 0.5
var is_bloom_enabled := false
var master_volume := 1.0

func update_brightness(value):
	brightness = value
	emit_signal("brightness_updated", value)

func toggle_bloom(enabled: bool):
	is_bloom_enabled = enabled
	emit_signal("bloom_toggled", enabled)

func set_volume(value: float):
	master_volume = value
	AudioServer.set_bus_volume_db(0, linear_to_db(value)) # Linear to decibels
	
func save_settings():
	var config = ConfigFile.new()
	config.set_value("settings", "brightness", brightness)
	config.set_value("settings", "bloom", is_bloom_enabled)
	config.set_value("settings", "volume", master_volume)
	config.save(SAVE_PATH)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	if err == OK:
		brightness = config.get_value("settings", "brightness", brightness)
		is_bloom_enabled = config.get_value("settings", "bloom", is_bloom_enabled)
		master_volume = config.get_value("settings", "volume", master_volume)
