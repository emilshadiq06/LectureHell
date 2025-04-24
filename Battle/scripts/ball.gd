extends AnimatableBody2D
var move = Vector2.LEFT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _physics_process(delta: float) -> void:
	
	
	global_position.x = global_position.x + 10
	
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
