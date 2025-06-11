extends stat
class_name playerStat

#@export var name : String
@export var take_damage: int = 0
#@export var max_hp : int = 20
#@export var hp : int = 20
@export var max_pp: int = 20
@export var pp: int = 20
@export var weapons: Array[Array]
#@export var weapon_speed: float = 1
@export var money : float
@export var walk: float = 250
@export var dash: float = 0.1
@export var skill : Array[skill_item]
