extends CanvasLayer

const INVENTORY_ITEM_SCENE: PackedScene = preload("res://InventoryItem.tscn")

const MIN_HEALTH: int = 23

var max_hp: int = 4

onready var player: KinematicBody2D = get_parent().get_node("Player")
onready var health_bar: TextureProgress = get_node("HealthBar")
onready var health_bar_tween: Tween = get_node("HealthBar/Tween")

onready var inventory: HBoxContainer = get_node("PanelContainer/Inventory")


func _ready() -> void:
	max_hp = player.max_hp
	_update_health_bar(100)
	
	
func _update_health_bar(new_value: int) -> void:
	var __ = health_bar_tween.interpolate_property(health_bar, "value", health_bar.value, new_value, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	__ = health_bar_tween.start()


func _on_Player_hp_changed(new_hp: int) -> void:
	var new_health: int = int((100 - MIN_HEALTH) * float(new_hp) / max_hp) + MIN_HEALTH
	_update_health_bar(new_health)


func _on_Player_weapon_switched(prev_index: int, new_index: int) -> void:
	inventory.get_child(prev_index).deselect()
	inventory.get_child(new_index).select()


func _on_Player_weapon_picked_up(weapon_texture: Texture) -> void:
	var new_inventory_item: TextureRect = INVENTORY_ITEM_SCENE.instance()
	inventory.add_child(new_inventory_item)
	new_inventory_item.initialize(weapon_texture)


func _on_Player_weapon_droped(index: int) -> void:
	inventory.get_child(index).queue_free()
