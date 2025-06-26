extends Node

func _on_restart_pressed() -> void:
	emit_signal("restart")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
