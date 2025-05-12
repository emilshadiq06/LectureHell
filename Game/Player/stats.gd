class_name stat extends Node
var take_damage: int = 0
var hp : int = 40
var pp = 20
var inventory = []
var weapon = 1

func _ready() -> void:
	StatLoader.get_stats_player(self)

func update_stats():
	hp = StatLoader.hp
	pp = StatLoader.pp
	weapon = StatLoader.weapon
