extends Node

signal brightness_updated(value)
signal bloom_toggled(value)

func update_brightness(value):
	emit_signal("brightness_updated", value)
	
func toggle_bloom(value):
	emit_signal("bloom_toggled", value)
