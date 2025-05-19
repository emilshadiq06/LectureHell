extends stat

#func _ready() -> void:
#	hp = 35
func get_stats():
	hp = 35
	weapon = 0
	return [hp,weapon,pp,money,inventory]
