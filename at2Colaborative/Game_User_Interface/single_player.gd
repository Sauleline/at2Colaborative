extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Single_Player_Level_Select.tscn")
