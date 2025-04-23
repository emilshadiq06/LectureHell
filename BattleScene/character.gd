extends CharacterBody2D

@onready var _focus = $Focus
@onready var progress = $ProgressBar
@onready var animation_player = $AnimationPlayer
@export var MAX_HP :int = 20

var HP :int = 20:
	set (value):
		HP = value
		_update_progress_bar()
		_play_animation("hurt")

func _update_progress_bar():
	progress = (HP/MAX_HP) * 100

func _play_animation(anim:String):
	animation_player.play(anim)
	
func focus():
	_focus.show()
	
func unfocus():
	_focus.hide()
	
