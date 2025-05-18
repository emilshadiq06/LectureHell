extends Node

@onready var player: Character = $"../Player"
@onready var ui: CanvasLayer = $"../UI"

func _ready() -> void:
	ui.set_initial_health(player.get_health())
	
