extends Node
#,Vector2(0,-9.81),Vector2(0,9.81),Vector2(9.81,0),
var gravity: Vector2 = [Vector2(0,-9.81),Vector2(0,9.81),Vector2(9.81,0),Vector2(-9.81,0)].pick_random()
var velocity : Vector2 = Vector2(0,0)
@export var time: float = 5
var grav_disabler:bool = false
@onready var attk_target  = $"../../Player_base"
@export var priority : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../../../PlayerGroup".got_duration.connect(got_duration)
	if attk_target.grav_from_outside == Vector2(0,0) or (attk_target.grav_priority <= priority):# add priority to attacks #or  (($"../gravity"\ != null)):
		grav_disabler = true
		attk_target.grav_from_outside = gravity
		attk_target.grav_priority = priority
		attk_target.grav_affected = true

	attk_target.sprite.self_modulate =  Color("cyan")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time > 0:
		time -= delta
		#print(time)
	elif time<0 and time>-0.05 and grav_disabler:
		attk_target.grav_priority = 0
		attk_target.sprite.self_modulate =  Color("white")
		attk_target.grav_from_outside = Vector2(0,0)
		attk_target.grav_affected = false
	pass
func got_duration(duration:float):
	if duration < time:

		$"../../../PlayerGroup".bullet_hell_timer.start(time+3)

			#print("mogus22")

				
