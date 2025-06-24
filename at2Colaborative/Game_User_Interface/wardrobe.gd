extends CanvasLayer

func _ready():
	var p1 = "Guest"
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
		for i in range(len(p1.userHats)):
			$HatSelect.add_item(p1.userHats[i])

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")

func _on_hat_select_item_selected(index):
	var p1 = "Guest"
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
		AccessUsers.openUserProfiles()
		AccessUsers.saveUserFileName = AccessUsers.userProfiles.userProfilesDict[p1.userName]
	p1.currentHat = p1.userHats[index]
	AccessUsers.save_user()
