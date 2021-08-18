extends Node2D


func _init() -> void:
	randomize()
	
	var screen_size: Vector2 = OS.get_screen_size()
	var window_size: Vector2 = OS.get_window_size()
	
	OS.set_window_position(screen_size * 0.5 - window_size * 0.5)
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next"):
		get_tree().paused = true
