extends Node2D


func _init() -> void:
	randomize()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next"):
		get_tree().paused = true
