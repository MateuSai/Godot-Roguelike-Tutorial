extends CanvasLayer

@onready var ability_icon: TextureProgressBar = get_node("AbilityIcon")


func recharge_ability_animation(time: float) -> void:
	ability_icon.value = 100
	var tween: Tween = create_tween()
	tween.tween_property(ability_icon, "value", 0, time)

