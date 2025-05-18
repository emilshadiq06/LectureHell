extends stat

func _ready() -> void:
	hp = 10
	weapon = 0
func get_stats():

	return [hp,weapon,pp]
