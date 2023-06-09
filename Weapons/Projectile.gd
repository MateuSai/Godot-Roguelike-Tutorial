extends Hitbox

var enemy_exited: bool = false

var direction: Vector2 = Vector2.ZERO
var knife_speed: int = 0


func launch(initial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = initial_position
	direction = dir
	knockback_direction = dir
	knife_speed = speed

	rotation += dir.angle() + PI/4


func _physics_process(delta: float) -> void:
	position += direction * knife_speed * delta


func _on_ThrowableKnike_body_exited(_body: Node2D) -> void:
	if not enemy_exited:
		enemy_exited = true
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, true)
		set_collision_mask_value(3, true)
		set_collision_mask_value(4, true)


func _collide(body: Node2D) -> void:
	if enemy_exited:
		if body.has_method("take_damage"):
			body.take_damage(damage, knockback_direction, knockback_force)
		queue_free()
