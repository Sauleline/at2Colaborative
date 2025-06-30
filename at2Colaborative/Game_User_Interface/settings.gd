extends CanvasLayer

func _ready():
	var settings = AccessUsers.settings
	for i in $SliderSplitter.get_children():
		i.value = settings.vols[i.editor_description]
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(i.name), linear_to_db(i.value))
	$Fullscreen.button_pressed = settings.fullScreen

func exiting():
	pass
	#settings stuff was changed so this doesn't work atm
	#Global.settings.vols["sfx"] = $SliderSplitter/SFX.value
	#Global.settings.vols["mus"] = $SliderSplitter/Music.value
	#Global.settings.vols["mas"] = $SliderSplitter/Master.value
	#Global.settings["fullScreen"] = $Fullscreen.button_pressed
	
func _on_debug_level_pressed() -> void:
	exiting()
	get_tree().change_scene_to_file("res://Main_Game/Stages/templateStage.tscn")

func _on_back_pressed() -> void:
	exiting()
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")

func changeVolume(_value_changed: bool, bus: String):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear_to_db($SliderSplitter.find_child(bus).value))

func updateLabel(value_changed: float, bus: String):
	$SliderSplitter.find_child(bus).find_child("Level").text = str(int(value_changed*100))
