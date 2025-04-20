extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar
@onready var focus = $Focus
@export var MAX_HP : float = 20

var hp : float = 20:
	set(value):
		hp = value
		_update_progress_bar()
		_play_animation("hurt")


func _update_progress_bar():
	progress_bar.value = (hp/MAX_HP) * 100

func _play_animation(anim: String):
	animation_player.play(anim)

func _focus():
	focus.show()

func _unfocus():
	focus.hide()

func take_damage(value):
	hp -= value
