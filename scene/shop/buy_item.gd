extends Button
signal item_pos(item_index:int)
var item_index:int = 0
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_pressed() -> void:
	item_pos.emit(item_index)
	pass # Replace with function body.
