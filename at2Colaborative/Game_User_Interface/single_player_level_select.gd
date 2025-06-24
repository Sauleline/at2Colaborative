extends CanvasLayer

func _ready() -> void:
	var p1 = "Guest"
	var p2 = "Guest"
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne.userName
	if(Global.PlayerTwo):
		p2 = Global.PlayerTwo.userName
	$"Users Logged".text = 'Welcome Back '+ p1 + ' and ' + p2
	
func populateLeaderboard(level):
	for i in $Leaderboard/VBoxContainer.get_children():
		$Leaderboard/VBoxContainer.remove_child(i)
	var insertLabel = Label.new()
	insertLabel.text = str(level)
	$Leaderboard/VBoxContainer.add_child(insertLabel)
	for i in range(40):
		insertLabel = Label.new()
		insertLabel.text = str(i)
		$Leaderboard/VBoxContainer.add_child(insertLabel)
	
func _on_level_0_mouse_entered() -> void:
	populateLeaderboard(0)

func _on_level_1_mouse_entered() -> void:
	populateLeaderboard(1)
	
func _on_level_2_mouse_entered() -> void:
	populateLeaderboard(2)

func _on_level_3_mouse_entered() -> void:
	populateLeaderboard(3)

func _on_level_4_mouse_entered() -> void:
	populateLeaderboard(4)

func _on_level_5_mouse_entered() -> void:
	populateLeaderboard(5)

func _on_level_6_mouse_entered() -> void:
	populateLeaderboard(6)

func _on_level_7_mouse_entered() -> void:
	populateLeaderboard(7)

func _on_level_8_mouse_entered() -> void:
	populateLeaderboard(8)

func _on_level_9_mouse_entered() -> void:
	populateLeaderboard(9)
