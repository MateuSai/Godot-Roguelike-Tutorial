extends Weapon

const ARROW_SCENE: PackedScene = preload("res://Weapons/Arrow.tscn")


func shoot(offset: int) -> void:
	var arrow: Area2D = ARROW_SCENE.instance()
	get_tree().current_scene.add_child(arrow)
	arrow.launch(global_position, Vector2.LEFT.rotated(deg2rad(rotation_degrees + offset)), 400)
	
	
func triple_shoot() -> void:
	shoot(0)
	shoot(12)
	shoot(-12)
