extends CanvasLayer

@export var button: PackedScene

func _ready() -> void:
	var p1 = "Guest"
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne.userName
	$"Users Logged".text = 'Welcome Back '+ p1
	
	var levelCount = 10
	for i in range(levelCount):
		var instance = button.instantiate()
		instance.pressed.connect(_goToLevel.bind(i))
		instance.mouse_entered.connect(_populateLeaderboard.bind(i))
		instance.find_child("Level").text = "Level " + str(i)
		if Global.PlayerOne:
			if str(i) in Global.PlayerOne.personalBestScores.keys():
				var score = Global.PlayerOne.personalBestScores[str(i)]
				instance.find_child("PB").text = "PB : " + str(Global.intToSecMin(floor(score/10)))
		if i == 0:
			instance.get_children()[1].text = "Tutorial"
		$Grid.add_child(instance)
		
func sort_ascending(a, b):
	if str(a[1]) == "null":
		return false
	elif str(b[1]) == "null":
		return true
	elif a[1] < b[1]:
		return true
	return false
	
func _get_leaderboard(level):
	var leaderboard = []
	AccessUsers.openUserProfiles()
	for x in AccessUsers.globalSaveFile.userProfilesDict.keys():
		var user = AccessUsers.open_user(x)
		if str(level) in user.personalBestScores.keys():
			leaderboard.append([user.userName, user.personalBestScores[str(level)]])
		else:
			leaderboard.append([user.userName, "null"])
	leaderboard.sort_custom(sort_ascending)
	return leaderboard
		
var _populateLeaderboard = func populateLeaderboard(level: int):
	for i in $Leaderboard/vertContainer.get_children():
		$Leaderboard/vertContainer.remove_child(i)
	var insertLabel = Label.new()
	insertLabel.add_theme_font_size_override("font_size", 20)
	insertLabel.text = "Level "+str(level)
	$Leaderboard/vertContainer.add_child(insertLabel)
	var leaderboard = _get_leaderboard(level) 
	var count = 1
	for i in leaderboard:
		insertLabel = Label.new()
		insertLabel.add_theme_font_size_override("font_size", 20)
		var text = " "
		if str(i[1]) == "null":
			text = i[0] + " : TBC" 
		else:
			text = str(count) + ". " + i[0] + " : " + str(Global.intToSecMin(floor(i[1]/10)))
		insertLabel.text = text.pad_zeros(2)
		$Leaderboard/vertContainer.add_child(insertLabel)
		count = count + 1

var _goToLevel = func goToLevel(level: int):
	get_tree().change_scene_to_file("res://Main_Game/1Player/Stages/"+str(level)+".tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
