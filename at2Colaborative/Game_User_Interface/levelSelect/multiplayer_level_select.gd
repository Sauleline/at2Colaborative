extends CanvasLayer

@export var button: PackedScene

func _ready() -> void:
	var p1 = "Guest"
	var p2 = "Guest"
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne.userName
	if(Global.PlayerTwo):
		p2 = Global.PlayerTwo.userName
	$"Users Logged".text = 'Welcome Back '+ p1 + ' and '+p2
	
	var levelCount = 10
	for i in range(levelCount):
		var instance = button.instantiate()
		instance.pressed.connect(_goToLevel.bind(i))
		instance.get_children()[1].text = "Level " + str(i+1)
		$Grid.add_child(instance)

var _goToLevel = func goToLevel(level: int):
	get_tree().change_scene_to_file("res://Main_Game/2Player/Stages/"+str(level)+".tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/Title_Screen.tscn")
