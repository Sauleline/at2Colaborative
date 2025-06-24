extends CanvasLayer

func _ready() -> void:
	var p1 = "Guest"
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne.userName
	$"Users Logged".text = 'Welcome Back '+ p1
	
	var levelCount = 10
	var scene = preload("res://Game_User_Interface/singlePlayerButton.tscn")
	for i in range(levelCount):
		var instance = scene.instantiate()
		$Grid.add_child(instance)
	
	var temp = 0
	for i in $Grid.get_children():
		i.pressed.connect(_goToLevel.bind(temp))
		i.mouse_entered.connect(_populateLeaderboard.bind(temp))
		i.get_children()[1].text = "Level " + str(temp)
		if i.name == "Level 0":
			i.get_children()[1].text = "Tutorial"
		temp += 1

var _populateLeaderboard = func populateLeaderboard(level: int):
	for i in $Leaderboard/vertContainer.get_children():
		$Leaderboard/vertContainer.remove_child(i)
	var insertLabel = Label.new()
	insertLabel.text = "Level "+str(level)
	$Leaderboard/vertContainer.add_child(insertLabel)
	for i in range(40):
		insertLabel = Label.new()
		insertLabel.text = str(i).pad_zeros(2)
		$Leaderboard/vertContainer.add_child(insertLabel)

var _goToLevel = func goToLevel(level: int):
	get_tree().change_scene_to_file("res://Main_Game/Stages/"+str(level)+".tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
