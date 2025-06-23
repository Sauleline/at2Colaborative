extends CanvasLayer

func _ready():
	var p1 = "Guest"
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
		for i in range(len(p1.userCosmetics)):
			$HatSelect.add_item(p1.userCosmetics[i])

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")

func _on_hat_select_item_selected(index):
	var p1 = "Guest"
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
	p1.currentHat = p1.userCosmetics[index]
	Global.PlayerOne = p1
