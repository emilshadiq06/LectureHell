extends Area2D
@onready var animatedsprite = $AnimatedSprite2D
var timer : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer >0:
		timer -= delta
	else:
		$"../left".hide()
		$"../right".hide()
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right"):
		animatedsprite.play("pressed")
	if Input.is_action_just_pressed("left"):
		$"../left".show()
		timer = 0.1
	elif  Input.is_action_just_pressed("right"):
		$"../right".show()
		timer = 0.1
	
func attack():
	pass
		
