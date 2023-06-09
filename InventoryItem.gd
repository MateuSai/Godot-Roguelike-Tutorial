extends TextureRect

@onready var border: ReferenceRect = get_node("ReferenceRect")


@warning_ignore("shadowed_variable_base_class")
func initialize(texture: Texture2D) -> void:
	self.texture = texture


func select() -> void:
	border.show()


func deselect() -> void:
	border.hide()
