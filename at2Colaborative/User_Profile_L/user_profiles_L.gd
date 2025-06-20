class_name User_Profile 

extends Resource

@export var userProfilesDict = {}
@export var PlayerOne = false
@export var PlayerTwo = false

func addPlayerOne(playerOne):
	PlayerOne = playerOne

func addPlayerTwo(playerTwo):
	PlayerTwo = playerTwo

func get_user_names():
	pass

func add_user(user):
	var saveFilePath = user.userName + ".tres"
	userProfilesDict[user.userName] = saveFilePath

func remove_user(userName):
	userProfilesDict.erase(userName)
