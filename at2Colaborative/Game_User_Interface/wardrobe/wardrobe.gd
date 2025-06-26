extends CanvasLayer

var p1 = "Guest"

func _ready():
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
	$"Users Logged".text = 'Welcome Back '+ p1.userName
	var hatTexture = "res://art/hats/"+p1.currentHat+".png"
	$PlayerDisp/Hat.texture = load(hatTexture)
	var hatButtonGroup = ButtonGroup.new()
	for i in p1.userHats:
		hatTexture = "res://art/hats/"+i+".png"
		var hatButton = Button.new()
		hatButton.name = i
		hatButton.icon = load(hatTexture)
		hatButton.toggle_mode = true
		hatButton.button_group = hatButtonGroup
		$Hats.add_child(hatButton)
	hatButtonGroup.pressed.connect(_hatButtonPressed)
		
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")

var _hatButtonPressed = func hatButtonPressed(pressedButton: BaseButton):
	var hatTexture = "res://art/hats/"+pressedButton.name+".png"
	$PlayerDisp/Hat.texture = load(hatTexture)
	
