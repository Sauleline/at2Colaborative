extends CanvasLayer

func _on_debug_level_pressed() -> void:
	get_tree().change_scene_to_file("res://Main_Game/Stages/templateStage.tscn")
