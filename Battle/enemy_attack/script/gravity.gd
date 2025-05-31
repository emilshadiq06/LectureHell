extends Node
#,Vector2(0,-9.81),Vector2(0,9.81),Vector2(9.81,0),
var gravity: Vector2 = [Vector2(0,-9.81),Vector2(0,9.81),Vector2(9.81,0),Vector2(-9.81,0)].pick_random()
var velocity : Vector2 = Vector2(0,0)
@export var time: float = 5
@onready var attk_target  = $"../../Player_base"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if attk_target.grav_from_outside == Vector2(0,0):
		
		attk_target.grav_from_outside = gravity
		attk_target.velocity = gravity*0.002
		attk_target.grav_affected = true
	attk_target.sprite.self_modulate =  Color("cyan")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time > 0:
		time -= delta
	elif time<0 and time>-0.05:
		
		attk_target.sprite.self_modulate =  Color("white")
		attk_target.grav_from_outside = Vector2(0,0)
		attk_target.grav_affected = false
	pass
