extends "access_user_files_L.gd"

@onready var UserNameInput = $UserInputName 
var bannedNames = ["GlobalSaveFile"]

func addUser():
	var username = UserNameInput.text
	new_user(username)

func _on_add_user_pressed() -> void:
	var input = UserNameInput.text
	input = input.strip_edges()
	if input.is_empty():
		pass
	elif (input in bannedNames):
		$Label.text = "Not Allowed!"
	else:
		addUser()
		backToUserSelect() 

func backToUserSelect():
	get_tree().change_scene_to_file("res://User_Profile_L/User_Profile_Select.tscn")

func _on_exit_pressed() -> void:
	backToUserSelect()
