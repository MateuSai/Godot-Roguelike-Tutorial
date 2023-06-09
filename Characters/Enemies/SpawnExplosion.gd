extends AnimatedSprite2D


func _ready() -> void:
	play("default")


func _on_SpawnExplosion_animation_finished() -> void:
	queue_free()
