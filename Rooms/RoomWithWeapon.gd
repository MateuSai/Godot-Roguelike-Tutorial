extends Room

const WEAPONS: Array = [preload("res://Weapons/WarHammer.tscn"), preload("res://Weapons/BattleAxe.tscn")]

onready var weapon_pos: Position2D = get_node("WeaponPos")


func _ready() -> void:
	var weapon: Node2D = WEAPONS[randi() % WEAPONS.size()].instance()
	weapon.position = weapon_pos.position
	weapon.on_floor = true
	add_child(weapon)

