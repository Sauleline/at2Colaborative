extends "access_user_files_L.gd"

@onready var UserNameInput = $UserInputName 

func addUser():
	var username = UserNameInput.text
	new_user(username)
	save_user()

func _on_add_user_pressed() -> void:
	var input = UserNameInput.text
	input = input.strip_edges()
	if input.is_empty():
		print("empty")
		pass
	else:
		addUser()
		backToUserSelect() 

func backToUserSelect():
	get_tree().change_scene_to_file("res://User_Profile_L/User_Profile_Select.tscn")

func _on_exit_pressed() -> void:
	backToUserSelect()
