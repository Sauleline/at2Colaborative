extends "access_user_files_L.gd"

@onready var OptionUserSelect = $OptionSelectUser 
@onready var PlayerOneLabel = $PlayerOne
@onready var PlayerTwoLabel = $PlayerTwo
var buttonPressed = true # true = player one, false = player two 
var PlayerOne = false
var PlayerTwo = false

func populate_user_list():
	OptionUserSelect.clear()
	var index = 0
	for x in userProfiles.userProfilesDict:
		OptionUserSelect.add_item(x, index)
		saveUserFileName = userProfiles.userProfilesDict[x]
		open_user()
		user.buttonIndex = index
		index = index + 1
		
func _ready():
	verifySaveDirectory(saveFilePath)
	openUserProfiles()
	populate_user_list()
	
func selectUser():
	var ID = OptionUserSelect.get_selected_id()
	var Text = OptionUserSelect.get_item_text(ID)
	saveUserFileName = userProfiles.userProfilesDict[Text]
	open_user()
	return user 

func _on_select_user_pressed() -> void:
	var userSelected = selectUser()
	if buttonPressed: #player one
		if PlayerOne is not bool:
			OptionUserSelect.set_item_disabled(PlayerOne.buttonIndex, false)
		OptionUserSelect.set_item_disabled(userSelected.buttonIndex, true)
		PlayerOne = userSelected
		PlayerOneLabel.text = PlayerOne.userName
	else: # player two
		if PlayerTwo is not bool:
			OptionUserSelect.set_item_disabled(PlayerTwo.buttonIndex, false)
		OptionUserSelect.set_item_disabled(userSelected.buttonIndex, true)
		PlayerTwo = userSelected
		PlayerTwoLabel.text = PlayerTwo.userName
	
	
func resetUser():
	var userSelected = selectUser()
	if PlayerOne is not bool:
		if PlayerOne.userName == userSelected.userName:
			PlayerOne = false
			PlayerOneLabel.text = "Player One"
	elif PlayerTwo is not bool:
		if PlayerTwo.userName == userSelected.userName:
			PlayerTwo = false
			PlayerTwoLabel.text = "Player Two"
	else:
		pass
	
func removeUser():
	var ID = OptionUserSelect.get_selected_id()
	var Text = OptionUserSelect.get_item_text(ID)
	var userFilePath = userProfiles.userProfilesDict[Text]
	OptionUserSelect.remove_item(ID)
	userProfiles.remove_user(Text)
	removeUserFile(userFilePath)

func _on_remove_user_pressed() -> void:
	if not userProfiles.userProfilesDict:
		pass
	else:
		resetUser()
		removeUser() 

func _on_create_new_user_pressed() -> void:
	get_tree().change_scene_to_file("res://User_Profile_L/User_Profile_Create.tscn")

func _on_player_one_button_pressed() -> void:
	buttonPressed = true

func _on_player_two_button_pressed() -> void:
	buttonPressed = false

func _on_back_button_pressed() -> void:
	Global.addPlayers(PlayerOne, PlayerTwo)
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
