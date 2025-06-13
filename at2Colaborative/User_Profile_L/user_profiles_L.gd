extends Node

class_name userProfiles 

@export var userProfilesDict = {}

func get_user_names():
	pass

func add_user(userName):
	var saveFilePath = userName + ".tres"
	userProfilesDict[userName] = saveFilePath

func remove_user(userName):
	userProfilesDict.erase(userName)
