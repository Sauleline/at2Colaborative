extends Area2D

@export var hemer: Texture2D
@export_range(1, 1000) var hemerChance: int = 1000

var val = 1

func _ready():
	if randi_range(1, hemerChance) == 1:
		$Sprite.texture = hemer
		val = 999
