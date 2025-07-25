extends CanvasLayer

var p1 = User.new()
var hatButtonGroup = ButtonGroup.new()

func _ready():
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
	else:
		p1.userName = "Guest"
	$"Users Logged".text = 'Welcome Back '+ p1.userName
	var hatTexture = "res://art/hats/"+p1.currentHat+".png"
	$PlayerDisp/Hat.texture = load(hatTexture)
	$PlayerDisp.self_modulate = p1.colour
	$ColorPicker.color = p1.colour
	hatButtonGroup.allow_unpress = false
	for i in p1.userHats:
		hatTexture = "res://art/hats/"+i+".png"
		var hatButton = Button.new()
		hatButton.name = i
		hatButton.icon = load(hatTexture)
		hatButton.toggle_mode = true
		hatButton.button_group = hatButtonGroup
		$Hats.add_child(hatButton)
	hatButtonGroup.pressed.connect(_hatButtonPressed)
	for i in hatButtonGroup.get_buttons():
		if i.name == p1.currentHat:
			i.set_pressed_no_signal(true)

func _on_back_pressed() -> void:
	if(Global.PlayerOne):
		p1 = AccessUsers.open_user(Global.PlayerOne.userName)
		p1.colour = $ColorPicker.color
		p1.currentHat = hatButtonGroup.get_pressed_button().name.lstrip("&")
		AccessUsers.save_user(p1)
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")

var _hatButtonPressed = func hatButtonPressed(pressedButton: BaseButton):
	var hatTexture = "res://art/hats/"+pressedButton.name+".png"
	$PlayerDisp/Hat.texture = load(hatTexture)

func _on_color_picker_color_changed(color: Color) -> void:
	$PlayerDisp.self_modulate = color

func _on_shop_pressed() -> void:
	if(Global.PlayerOne):
		p1 = AccessUsers.open_user(Global.PlayerOne.userName)
		p1.colour = $ColorPicker.color
		p1.currentHat = hatButtonGroup.get_pressed_button().name.lstrip("&")
		AccessUsers.save_user(p1)
		get_tree().change_scene_to_file("res://Game_User_Interface/wardrobe/shop.tscn")
