extends "access_user_files_L.gd"

@onready var OptionUserSelect = $OptionSelectUser 

func populate_user_list():
	OptionUserSelect.clear()
	for i in userProfiles.userProfilesDict.keys():
		OptionUserSelect.add_item(i, -1)
	
func _ready():
	verifySaveDirectory(saveFilePath)
	openUserProfiles()
	populate_user_list()
	
func selectUser():
	var ID = OptionUserSelect.get_selected_id()
	var Text = OptionUserSelect.get_item_text(ID)
	saveUserFileName = userProfiles.userProfilesDict[Text]
	open_user()
	print(user.userName)

func _on_select_user_pressed() -> void:
	selectUser()
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
	
func removeUser():
	var ID = OptionUserSelect.get_selected_id()
	var Text = OptionUserSelect.get_item_text(ID)
	var userFilePath = userProfiles.userProfilesDict[Text]
	OptionUserSelect.remove_item(ID)
	userProfiles.remove_user(Text)
	removeUserFile(userFilePath)
	OptionUserSelect.clear()
	populate_user_list()

func _on_remove_user_pressed() -> void:
	if not userProfiles.userProfilesDict:
		pass
	else:
		removeUser() # Replace with function body.

func _on_create_new_user_pressed() -> void:
	get_tree().change_scene_to_file("res://User_Profile_L/User_Profile_Create.tscn")
