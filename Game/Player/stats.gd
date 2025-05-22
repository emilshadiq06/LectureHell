class_name stat extends Node
var take_damage: int = 0
var max_hp : int =20
var hp : int = 20
var pp: int = 20
var inventory = []
var weapon = 1
var money : int

#func _ready() -> void:
#	StatLoader.get_stats_player(self)

func update_stats():
	max_hp = StatLoader.max_hp
	hp = StatLoader.hp
	pp = StatLoader.pp
	weapon = StatLoader.weapon
	money =  StatLoader.money

func addhealth(hp_regen,pp_regen):
	StatLoader.hp += hp_regen
	StatLoader.pp += pp_regen
	update_stats()
	print(hp)
	
