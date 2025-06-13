extends Node

var saveFilePath = "user://save/"
var saveFileName = "User_Save.tres"

var user1 = User.new()

var test = "test"

func _ready():
	user1.user_name = "Test"
	verifySaveDirectory(saveFilePath)
	save_user(user1)
	var user2 = load_data()
	print(user2.user_name)

func verifySaveDirectory(path : String):
	DirAccess.make_dir_absolute(path)
	
func save_user(user):
	ResourceSaver.save(user, saveFilePath+saveFileName)
	

func load_data():
	return ResourceLoader.load(saveFilePath+saveFileName).duplicate(true)

	
	
