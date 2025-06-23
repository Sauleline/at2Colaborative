extends Node

var saveFilePath = "user://save/"
var saveMainFileName = "UserProfiles.tres"
var saveUserFileName = " "
var user = User.new()
var userProfiles = User_Profile.new()

func openUserProfiles():
	if ResourceLoader.exists(saveFilePath + saveMainFileName):
		userProfiles = ResourceLoader.load(saveFilePath + saveMainFileName).duplicate(true)
	else:
		ResourceSaver.save(userProfiles, saveFilePath+saveMainFileName)
		get_tree().change_scene_to_file("res://User_Profile_L/User_Profile_Create.tscn")
	
func _ready():
	verifySaveDirectory(saveFilePath)
	openUserProfiles()
	returningUsers()
	
func returningUsers():
	verifySaveDirectory(saveFilePath)
	openUserProfiles()
	if (userProfiles.PlayerOne):
		saveUserFileName = userProfiles.userProfilesDict[userProfiles.PlayerOne]
		open_user()
		Global.PlayerOne = user
	
	if (userProfiles.PlayerTwo):
		saveUserFileName = userProfiles.userProfilesDict[userProfiles.PlayerTwo]
		open_user()
		Global.PlayerTwo = user

func verifySaveDirectory(path : String):
	DirAccess.make_dir_absolute(path)
	
func new_user(userName):
	user.userName = userName
	saveUserFileName = user.userName+".tres"
	userProfiles.add_user(user)

func removeUserFile(userFilePath):
	var dir = DirAccess.open(saveFilePath)
	dir.remove(saveFilePath+userFilePath)
	ResourceSaver.save(userProfiles, saveFilePath+saveMainFileName)
	
func save_user():
	ResourceSaver.save(user, saveFilePath+saveUserFileName)
	ResourceSaver.save(userProfiles, saveFilePath+saveMainFileName)
	
func open_user():
	if ResourceLoader.exists(saveFilePath + saveUserFileName):
		user = ResourceLoader.load(saveFilePath+saveUserFileName).duplicate(true)

	
	
