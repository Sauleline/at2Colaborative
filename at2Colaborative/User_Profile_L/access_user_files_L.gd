extends Node

var saveFilePath = "user://save/"
var saveMainFileName = "GlobalSaveFile.tres"
var saveUserFileName = " "
var globalSaveFile = Global_Save_File.new()
var settings = globalSaveFile.settings

func openUserProfiles():
	if ResourceLoader.exists(saveFilePath + saveMainFileName):
		globalSaveFile = ResourceLoader.load(saveFilePath + saveMainFileName).duplicate(true)
		settings = globalSaveFile.settings
	else:
		ResourceSaver.save(globalSaveFile, saveFilePath+saveMainFileName)
		globalSaveFile.settings = Settings.new()
		settings = globalSaveFile.settings
	
func _ready():
	verifySaveDirectory(saveFilePath)
	openUserProfiles()
	returningUsers()
	
func returningUsers():
	verifySaveDirectory(saveFilePath)
	openUserProfiles()
	if (globalSaveFile.PlayerOne):
		var user = open_user(globalSaveFile.PlayerOne.userName)
		Global.PlayerOne = user
	if (globalSaveFile.PlayerTwo):
		var user = open_user(globalSaveFile.PlayerTwo.userName)
		Global.PlayerTwo = user
	Global.settings = globalSaveFile.settings

func verifySaveDirectory(path : String):
	DirAccess.make_dir_absolute(path)
	
func new_user(userName):
	var user = User.new()
	user.userName = userName
	saveUserFileName = user.userName+".tres"
	globalSaveFile.add_user(user)
	save_user(user)

func removeUserFile(userFilePath):
	var dir = DirAccess.open(saveFilePath)
	dir.remove(saveFilePath+userFilePath)
	ResourceSaver.save(globalSaveFile, saveFilePath+saveMainFileName)
	
func save_user(user):
	saveUserFileName = globalSaveFile.userProfilesDict[user.userName]
	ResourceSaver.save(user, saveFilePath+saveUserFileName)
	ResourceSaver.save(globalSaveFile, saveFilePath+saveMainFileName)
	
func open_user(userName):
	saveUserFileName = globalSaveFile.userProfilesDict[userName]
	if ResourceLoader.exists(saveFilePath + saveUserFileName):
		return ResourceLoader.load(saveFilePath+saveUserFileName).duplicate(true)

func save_updates():
	globalSaveFile.settings = Global.settings
	ResourceSaver.save(globalSaveFile, saveFilePath+saveMainFileName)
