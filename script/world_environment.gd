extends WorldEnvironment

func _ready() -> void:
	GlobalSettings.connect("brightness_updated",Callable(self, "_on_brightness_updated"))
	GlobalSettings.connect("bloom_toggled",Callable(self, "_on_bloom_toggled"))
	
func _on_brightness_updated(value):
	environment.adjustment_brightness = value

func _on_bloom_toggled(value):
	environment.glow_enabled = value
