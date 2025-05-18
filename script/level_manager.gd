extends Node

@onready var player: Character = $"../Player" 
@onready var ui: CanvasLayer = $"../UI"

func _ready() -> void:
	ui.set_initial_health(player.get_health())
	player.player_damaged.connect(on_player_damaged)

func on_player_damaged(current_health: int):
	ui.decrease_health(current_health)
	
