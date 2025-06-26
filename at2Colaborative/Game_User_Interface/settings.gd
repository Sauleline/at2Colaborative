extends CanvasLayer

func _ready():
	var settings = AccessUsers.load_settings()
	for i in $SliderSplitter.get_children():
		i.value = settings[i.get_index()]

func _on_debug_level_pressed() -> void:
	AccessUsers.save_settings_volume($SliderSplitter/SFX.value, $SliderSplitter/Music.value, $SliderSplitter/Master.value)
	get_tree().change_scene_to_file("res://Main_Game/Stages/templateStage.tscn")

func _on_back_pressed() -> void:
	AccessUsers.save_settings_volume($SliderSplitter/SFX.value, $SliderSplitter/Music.value, $SliderSplitter/Master.value)
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")

func changeVolume(_value_changed: bool, bus: String):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear_to_db($SliderSplitter.find_child(bus).value))

func updateLabel(value_changed: float, bus: String):
	$SliderSplitter.find_child(bus).find_child("Level").text = str(int(value_changed*100))
