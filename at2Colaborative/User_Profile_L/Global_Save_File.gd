class_name Global_Save_File

extends Resource

@export var userProfilesDict = {}
@export var PlayerOne = false
@export var PlayerTwo = false
@export var settings = Settings.new()

func add_user(user):
	var saveFilePath = user.userName + ".tres"
	userProfilesDict[user.userName] = saveFilePath

func remove_user(userName):
	userProfilesDict.erase(userName)
