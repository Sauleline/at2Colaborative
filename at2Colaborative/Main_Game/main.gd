extends Node

@export var stageNum = 0

func _ready():
	var stageTo = "res://Main_Game/Stages/stage%s.tscn"%str(stageNum)
	print(stageTo)
	get_tree().change_scene_to_file(stageTo)
