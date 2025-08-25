@tool
extends TextureButton

@export var text: String:
	set(newText):
		text = newText
		$Text.text = text
@export var fontSize: int:
	set(newSize):
		fontSize = newSize
		$Text.add_theme_font_size_override("font_size", fontSize)
@export var buttonColour: Color = Color(1,1,1):
	set(newColour):
		buttonColour = newColour
		self_modulate = buttonColour
