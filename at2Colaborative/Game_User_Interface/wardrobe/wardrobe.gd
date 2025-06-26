extends CanvasLayer

var p1 = "Guest"

func _ready():
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
	$"Users Logged".text = 'Welcome Back '+ p1.userName
	for i in p1.userHats:
		var hatButton = TextureButton.new()
		hatButton.toggle_mode = true
		hatButton.add_to_group("res://Game_User_Interface/Wardrobe/hatButtonGroup.tres",false)
		hatButton.name = i
		hatButton.texture_normal = load("res://art/hats/gibus.png")
		$Hats.add_child(hatButton)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
