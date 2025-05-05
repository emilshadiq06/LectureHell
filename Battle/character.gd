extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar
@onready var focus = $Focus
@export var MAX_HP : float = 20
var weapon : int = 0:
	set(value):
		weapon = value
var start_battle = true
var hp : float = 20:
	set(value):
		hp = value
		if start_battle == false:
			_update_progress_bar()
			_play_animation("hurt")

func _ready() -> void:
	
	await get_tree().create_timer(0.3).timeout
	start_battle = false
	_update_progress_bar()
	
func set_stats(stats):
	
	hp = stats[0]
	MAX_HP = stats[0]
	print("here")
	print(stats[1])
	weapon = stats[1]
	
	
func _update_progress_bar():
	progress_bar.value = (hp)

func _play_animation(anim: String):
	animation_player.play(anim)

func _focus():
	focus.show()

func _unfocus():
	focus.hide()

func take_damage(value):
	hp -= value
