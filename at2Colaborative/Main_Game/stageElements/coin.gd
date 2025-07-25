extends Area2D

@export var hemer: Texture2D

var val = 1

func _ready():
	if randi_range(1, 1000) == 1:
		$Sprite.texture = hemer
		val = 999
