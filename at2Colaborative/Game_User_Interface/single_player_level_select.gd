extends CanvasLayer


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://Main_Game/Stages/1player/tutorial.tscn")
