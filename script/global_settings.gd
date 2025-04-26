extends Node

signal brightness_updated(value)

func update_brightness(value):
	emit_signal("brightness_updated", value)
