extends KinematicBody2D
class_name Character, "res://Art/v1.1 dungeon crawler 16x16 pixel pack/heroes/knight/knight_idle_anim_f0.png"

const HIT_EFFECT_SCENE: PackedScene = preload("res://Characters/HitEffect.tscn")

const FRICTION: float = 0.15

export(int) var max_hp: int = 2
export(int) var hp: int = 2 setget set_hp
signal hp_changed(new_hp)

export(int) var accerelation: int = 40
export(int) var max_speed: int = 100

export(bool) var flying: bool = false

onready var state_machine: Node = get_node("FiniteStateMachine")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var mov_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	
	
func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * accerelation
	velocity = velocity.clamped(max_speed)
	
	
func take_damage(dam: int, dir: Vector2, force: int) -> void:
	if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead:
		_spawn_hit_effect()
		self.hp -= dam
		if name == "Player":
			SavedData.hp = hp
			if hp == 0:
				SceneTransistor.start_transition_to("res://Game.tscn")
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += dir * force
		else:
			state_machine.set_state(state_machine.states.dead)
			velocity += dir * force * 2
		
		
func set_hp(new_hp: int) -> void:
	hp = clamp(new_hp, 0, max_hp)
	emit_signal("hp_changed", hp)
	
	
func _spawn_hit_effect() -> void:
	var hit_effect: Sprite = HIT_EFFECT_SCENE.instance()
	add_child(hit_effect)
