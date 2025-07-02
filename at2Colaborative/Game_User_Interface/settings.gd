extends CanvasLayer

func _ready():
	var settings = AccessUsers.settings
	for i in $optionList.get_children():
		if i.name != "Fullscreen":
			i.value = settings.vols[i.name]
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index(i.name), linear_to_db(i.value))
	$optionList/Fullscreen.button_pressed = settings.fullScreen

func exiting():
	AccessUsers.openUserProfiles()
	for i in $optionList.get_children():
		if i.name != "Fullscreen":
			Global.settings.vols[i.name] = i.value
	Global.settings["fullScreen"] = $optionList/Fullscreen.button_pressed
	AccessUsers.save_updates()
	
func _on_debug_level_pressed() -> void:
	exiting()
	get_tree().change_scene_to_file("res://Main_Game/Stages/templateStage.tscn")

func _on_back_pressed() -> void:
	exiting()
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
	
func _on_no_save_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")

func changeVolume(_value_changed: bool, bus: String):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear_to_db($optionList.find_child(bus).value))

func updateLabel(value_changed: float, bus: String):
	$optionList.find_child(bus).find_child("Level").text = str(int(value_changed*100))
