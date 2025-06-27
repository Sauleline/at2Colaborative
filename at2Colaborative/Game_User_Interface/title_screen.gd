extends CanvasLayer

func _ready() -> void:
	var p1 = "Guest"
	var p2 = "Guest"
	AccessUsers.returningUsers()
	AccessUsers.load_settings()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne.userName
	if(Global.PlayerTwo):
		p2 = Global.PlayerTwo.userName
	$"Users Logged".text = 'Welcome Back '+ p1 + ' and ' + p2
	if Global.settings.fullScreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('SFX'), linear_to_db(Global.settings.vols["sfx"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Music'), linear_to_db(Global.settings.vols["mus"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Master'), linear_to_db(Global.settings.vols["mas"]))


func _on_multiplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Multiplayer_Level_Select.tscn")

func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Single_Player_Level_Select.tscn")

func _on_wardrobe_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/wardrobe/Wardrobe.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Settings.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_change_user_pressed() -> void:
	get_tree().change_scene_to_file("res://User_Profile_L/User_Profile_Select.tscn")
