extends Node

@onready var player: Character = $"../Player" 
@onready var ui: CanvasLayer = $"../UI"
@onready var wave_spawner: WaveSpawner = $"../WaveSpawner"
@onready var enemy_movement_points: Node = $"../EnemyMovementPoints"

const VLAD_BOSS = preload("res://scene/vlad_boss.tscn")

func _ready() -> void:
	ui.set_initial_health(player.get_health())
	player.player_damaged.connect(on_player_damaged)
	wave_spawner.starting_wave.connect(ui.on_wave_started)
	wave_spawner.waves_finished.connect(on_waves_finished)
	
func on_waves_finished():
	var vlad_boss = VLAD_BOSS.instantiate()
	get_tree().root.add_child(vlad_boss)
	
	vlad_boss.global_position = Vector2(1116, 310)
	vlad_boss.movement_points = enemy_movement_points.get_children()
	vlad_boss.init()
	

func on_player_damaged(current_health: int):
	ui.decrease_health(current_health)
	
