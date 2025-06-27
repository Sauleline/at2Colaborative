extends TextureButton

@export var text: String
@export var fontSize: int = 60
@export var buttonColour: Color = Color(1,1,1)

func _ready():
	$Text.text = text
	$Text.add_theme_font_size_override("font_size", fontSize)
	self_modulate = buttonColour
