extends Node2D
class_name Weapon, "res://Art/v1.1 dungeon crawler 16x16 pixel pack/heroes/knight/weapon_sword_1.png"

export(bool) var on_floor: bool = false

export var ranged_weapon: bool = false
export var rotation_offset: int = 0

var can_active_ability: bool = true

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var hitbox: Area2D = get_node("Node2D/Sprite/Hitbox")
onready var charge_particles: Particles2D = get_node("Node2D/Sprite/ChargeParticles")
onready var player_detector: Area2D = get_node("PlayerDetector")
onready var tween: Tween = get_node("Tween")
onready var cool_down_timer: Timer = get_node("CoolDownTimer")
onready var ui: CanvasLayer = get_node("UI")
onready var ability_icon: TextureProgress = ui.get_node("AbilityIcon")


func _ready() -> void:
	if not on_floor:
		player_detector.set_collision_mask_bit(0, false)
		player_detector.set_collision_mask_bit(1, false)


func get_input() -> void:
	if Input.is_action_just_pressed("ui_attack") and not animation_player.is_playing():
		animation_player.play("charge")
	elif Input.is_action_just_released("ui_attack"):
		if animation_player.is_playing() and animation_player.current_animation == "charge":
			animation_player.play("attack")
		elif charge_particles.emitting:
			animation_player.play("strong_attack")
	elif Input.is_action_just_pressed("ui_active_ability") and animation_player.has_animation("active_ability") and not is_busy() and can_active_ability:
		can_active_ability = false
		cool_down_timer.start()
		ui.recharge_ability_animation(cool_down_timer.wait_time)
		animation_player.play("active_ability")
			
			
func move(mouse_direction: Vector2) -> void:
	if ranged_weapon:
		rotation_degrees = rad2deg(mouse_direction.angle()) + rotation_offset
	else:
		if not animation_player.is_playing() or animation_player.current_animation == "charge":
			rotation = mouse_direction.angle()
			hitbox.knockback_direction = mouse_direction
			if scale.y == 1 and mouse_direction.x < 0:
				scale.y = -1
			elif scale.y == -1 and mouse_direction.x > 0:
				scale.y = 1
			
			
func cancel_attack() -> void:
	animation_player.play("cancel_attack")
	
	
func is_busy() -> bool:
	if animation_player.is_playing() or charge_particles.emitting:
		return true
	return false


func _on_PlayerDetector_body_entered(body: KinematicBody2D) -> void:
	if body != null:
		player_detector.set_collision_mask_bit(0, false)
		player_detector.set_collision_mask_bit(1, false)
		body.pick_up_weapon(self)
		position = Vector2.ZERO
	else:
		var __ = tween.stop_all()
		assert(__)
		player_detector.set_collision_mask_bit(1, true)
		
		
func interpolate_pos(initial_pos: Vector2, final_pos: Vector2) -> void:
	var __ = tween.interpolate_property(self, "position", initial_pos, final_pos, 0.8, Tween.TRANS_QUART, Tween.EASE_OUT)
	assert(__)
	__ = tween.start()
	assert(__)
	player_detector.set_collision_mask_bit(0, true)


func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	player_detector.set_collision_mask_bit(1, true)


func _on_CoolDownTimer_timeout() -> void:
	can_active_ability = true
	
	
func show() -> void:
	ability_icon.show()
	.show()
	
	
func hide() -> void:
	ability_icon.hide()
	.hide()
	
	
func get_texture() -> Texture:
	return get_node("Node2D/Sprite").texture
