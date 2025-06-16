extends Node

var saveFilePath = "user://save/"
var saveMainFileName = "UserProfiles.tres"
var saveUserFileName = " "
var user = User.new()
var userProfiles = User_Profile.new()

func openUserProfiles():
	if ResourceLoader.exists(saveFilePath + saveMainFileName):
		userProfiles = ResourceLoader.load(saveFilePath + saveMainFileName).duplicate(true)
	
func getUser():
	return User
	
func _ready():
	verifySaveDirectory(saveFilePath)
	openUserProfiles()
	new_user("Child")
	print(user.userName)
	save_user()
	print(userProfiles.userProfilesDict)
	user = open_user()
	print(user.userName)
	

func verifySaveDirectory(path : String):
	DirAccess.make_dir_absolute(path)
	DirAccess.make_dir_absolute(path+saveMainFileName)
	
func new_user(userName):
	user.userName = userName
	saveUserFileName = user.userName+".tres"
	userProfiles.add_user(user)
	
func save_user():
	ResourceSaver.save(user, saveFilePath+saveUserFileName)
	
func open_user():
	if ResourceLoader.exists(saveFilePath + saveUserFileName):
		return ResourceLoader.load(saveFilePath+saveUserFileName).duplicate(true)

	
	
