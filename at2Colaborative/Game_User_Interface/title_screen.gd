extends CanvasLayer

func _ready() -> void:
	var p1 = "Guest"
	var p2 = "Guest"
	AccessUsers.returningUsers()
	if(Global.getPlayerOne()):
		p1 = Global.getPlayerOne().userName
	if(Global.getPlayerTwo()):
		p2 = Global.getPlayerTwo().userName
	$"Users Logged".text = 'Welcome Back '+ p1 + ' and ' + p2

func _on_multiplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Multiplayer_Level_Select.tscn")


func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Single_Player_Level_Select.tscn")

func _on_wardrobe_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Wardrobe.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Settings.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_change_user_pressed() -> void:
	get_tree().change_scene_to_file("res://User_Profile_L/User_Profile_Select.tscn")
	
