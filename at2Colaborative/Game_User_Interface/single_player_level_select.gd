extends CanvasLayer

func _ready() -> void:
	var p1 = "Guest"
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne.userName
	$"Users Logged".text = 'Welcome Back '+ p1
	
func populateLeaderboard(level: int):
	for i in $Leaderboard/vertContainer.get_children():
		$Leaderboard/vertContainer.remove_child(i)
	var insertLabel = Label.new()
	insertLabel.text = "Level "+str(level)
	$Leaderboard/vertContainer.add_child(insertLabel)
	for i in range(40):
		insertLabel = Label.new()
		insertLabel.text = str(i).pad_zeros(2)
		$Leaderboard/vertContainer.add_child(insertLabel)

func goToLevel(level: int):
	get_tree().change_scene_to_file("res://Main_Game/Stages/"+str(level)+".tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
