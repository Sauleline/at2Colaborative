extends "access_user_files_L.gd"

@onready var OptionUserSelect = $OptionSelectUser 
@onready var UserNameInput = $UserInputName 

func populate_user_list():
	OptionUserSelect.clear()
	for i in userProfiles.userProfilesDict.keys():
		OptionUserSelect.add_item(i, -1)
	
func _ready():
	verifySaveDirectory(saveFilePath)
	openUserProfiles()	
	print(userProfiles.userProfilesDict)
	populate_user_list()
	
func selectUser():
	var ID = OptionUserSelect.get_selected_id()
	var Text = OptionUserSelect.get_item_text(ID)
	saveUserFileName = userProfiles.userProfilesDict[Text]
	open_user()
	print(user.userName)

func _on_select_user_pressed() -> void:
	selectUser()
	 # Replace with function body.

func addUser():
	var username = UserNameInput.text
	new_user(username)
	save_user()
	OptionUserSelect.clear()
	populate_user_list()
	

func _on_add_user_pressed() -> void:
	addUser() 
