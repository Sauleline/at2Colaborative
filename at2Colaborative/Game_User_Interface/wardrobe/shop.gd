extends CanvasLayer

var p1 = User.new()
var hatDir = "res://art/hats/"

func _ready():
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
	else:
		p1.userName = "Guest"
	$"Users Logged".text = 'Welcome Back '+ p1.userName
	var dir = DirAccess.get_files_at(hatDir)
	var hatArr = []
	for i in dir:
		if i.ends_with(".import"):
			pass
		else:
			hatArr.append(i)
	print(hatArr)
	for i in hatArr:
		if i.rstrip(".png") in p1.userHats:
			pass
		else:
			var hatTexture = "res://art/hats/"+i
			var hatButton = Button.new()
			hatButton.name = i
			hatButton.icon = load(hatTexture)
			$Hats.add_child(hatButton)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
