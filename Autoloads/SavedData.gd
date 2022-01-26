extends Node

var num_floor: int = 0

var hp: int = 4
var weapons: Array = []
var equipped_weapon_index: int = 0

func reset_data() -> void:
	num_floor = 0
	
	hp = 4
	weapons = []
	equipped_weapon_index = 0

