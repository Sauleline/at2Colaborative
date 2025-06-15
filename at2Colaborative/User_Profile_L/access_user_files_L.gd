extends Node

var saveFilePath = "user://save/"
var saveMainFileName = "UserProfiles.tres"
var saveUserFileName = " "
var userProfiles 
var user 

func openUserProfiles():
	userProfiles = ResourceLoader.load(saveFilePath+saveMainFileName).duplicate(true)
	
func getUser():
	return User
	
func _ready():
	verifySaveDirectory(saveFilePath)
	openUserProfiles()
	new_user("Child")
	save_user(user)
	
	

func verifySaveDirectory(path : String):
	DirAccess.make_dir_absolute(path)
	
func new_user(userName):
	user.user_name = userName
	userProfiles.add_user(user.user_name)
	
func save_user(user):
	ResourceSaver.save(user, saveFilePath+saveUserFileName)
	
func load_data():
	return ResourceLoader.load(saveFilePath+saveUserFileName).duplicate(true)

	
	
