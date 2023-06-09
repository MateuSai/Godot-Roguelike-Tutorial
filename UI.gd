extends CanvasLayer

const INVENTORY_ITEM_SCENE: PackedScene = preload("res://InventoryItem.tscn")

const MIN_HEALTH: int = 23

var max_hp: int = 4

@onready var player: CharacterBody2D = get_parent().get_node("Player")
@onready var health_bar: TextureProgressBar = get_node("HealthBar")

@onready var inventory: HBoxContainer = get_node("PanelContainer/Inventory")


func _ready() -> void:
	max_hp = player.max_hp
	_update_health_bar(100)


func _update_health_bar(new_value: int) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(health_bar, "value", new_value, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)


func _on_Player_hp_changed(new_hp: int) -> void:
	var new_health: int = int((100 - MIN_HEALTH) * float(new_hp) / max_hp) + MIN_HEALTH
	_update_health_bar(new_health)


func _on_Player_weapon_switched(prev_index: int, new_index: int) -> void:
	inventory.get_child(prev_index).deselect()
	inventory.get_child(new_index).select()


func _on_Player_weapon_picked_up(weapon_texture: Texture2D) -> void:
	var new_inventory_item: TextureRect = INVENTORY_ITEM_SCENE.instantiate()
	inventory.add_child(new_inventory_item)
	new_inventory_item.initialize(weapon_texture)


func _on_Player_weapon_droped(index: int) -> void:
	inventory.get_child(index).queue_free()
