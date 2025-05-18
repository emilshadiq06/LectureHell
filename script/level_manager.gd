extends Node

@onready var player: Character = $"../Player" 
@onready var ui: CanvasLayer = $"../UI"
@onready var wave_spawner: WaveSpawner = $"../WaveSpawner"

func _ready() -> void:
	ui.set_initial_health(player.get_health())
	player.player_damaged.connect(on_player_damaged)
	wave_spawner.starting_wave.connect(ui.on_wave_started)
	wave_spawner.waves_finished.connect(on_waves_finished)
	
func on_waves_finished():
	pass

func on_player_damaged(current_health: int):
	ui.decrease_health(current_health)
	
