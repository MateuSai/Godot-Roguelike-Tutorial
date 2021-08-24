extends Hitbox


func _on_Hitbox_area_entered(area: Area2D) -> void:
	area.queue_free()
