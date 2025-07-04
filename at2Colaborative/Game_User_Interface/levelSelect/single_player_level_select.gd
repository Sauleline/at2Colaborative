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
		instance.get_children()[1].text = "Level " + str(i)
		if i == 0:
			instance.get_children()[1].text = "Tutorial"
		$Grid.add_child(instance)

var _populateLeaderboard = func populateLeaderboard(level: int):
	for i in $Leaderboard/vertContainer.get_children():
		$Leaderboard/vertContainer.remove_child(i)
	var insertLabel = Label.new()
	insertLabel.add_theme_font_size_override("font_size", 20)
	insertLabel.text = "Level "+str(level)
	$Leaderboard/vertContainer.add_child(insertLabel)
	for i in range(40):
		insertLabel = Label.new()
		insertLabel.add_theme_font_size_override("font_size", 20)
		insertLabel.text = str(i).pad_zeros(2)
		$Leaderboard/vertContainer.add_child(insertLabel)

var _goToLevel = func goToLevel(level: int):
	get_tree().change_scene_to_file("res://Main_Game/1Player/Stages/"+str(level)+".tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
