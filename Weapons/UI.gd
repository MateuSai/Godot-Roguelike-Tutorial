extends CanvasLayer

onready var ability_icon: TextureProgress = get_node("AbilityIcon")
onready var tween: Tween = get_node("Tween")


func recharge_ability_animation(time: float) -> void:
	var __ = tween.interpolate_property(ability_icon, "value", 100, 0, time)
	assert(__)
	__ = tween.start()
	assert(__)

