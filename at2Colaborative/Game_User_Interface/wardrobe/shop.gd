extends CanvasLayer

var p1 = User.new()
var hatDir = "res://art/hats/"
var hatPrice = {
	"banana.png" : 10, 
	"boat.png" : 10, 
	"bucket.png" : 15, 
	"cap.png" : 15, 
	"cat ears.png" : 50, 
	"crown.png" : 70, 
	"dame da ne guy.png" : 100, 
	"dave.png" : 900, 
	"gibus.png" : 70, 
	"icon.png" : 50, 
	"jackson.png" : 40, 
	"joel.png" : 30, 
	"none.png" : 0, 
	"party hat.png" : 20, 
	"propeller cap.png" : 30, 
	"pumpkin.png" : 20, 
	"santa.png" : 40, 
	"summer hat.png" : 20, 
	"team captain.png" : 40, 
	"top hat.png" : 80, 
	"unicorn.png" : 30, 
	"witch.png" : 20}

func _ready():
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
	else:
		p1.userName = "Guest"
	$"Users Logged".text = 'Welcome Back '+ p1.userName
	$"User Money".text = "You have $" + str(p1.piggyBank)
	$KROMER.hide()
	$KROMER.disabled = true
	var dir = DirAccess.get_files_at(hatDir)
	var hatArr = []
	for i in dir:
		if i.ends_with(".import"):
			pass
		else:
			hatArr.append(i)
	for i in hatArr:
		if i.trim_suffix(".png") in p1.userHats:
			pass
		else:
			var hatTexture = "res://art/hats/"+i
			var hatButton = Button.new()
			hatButton.name = i
			hatButton.icon = load(hatTexture)
			if i in hatPrice:
				hatButton.text = "$" + str(hatPrice[i])
				hatButton.pressed.connect(_buyHat.bind(i.trim_suffix(".png"), hatPrice[i]))
			else:
				hatButton.text = str("$10")
				hatButton.pressed.connect(_buyHat.bind(i.trim_suffix(".png"), 10))
			$Hats.add_child(hatButton)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_User_Interface/wardrobe/Wardrobe.tscn")

var _buyHat = func buyHat(hat: String, price: int):
	if Global.PlayerOne.piggyBank < price:
		pass
	else:
		p1.currentHat = hat
		p1.userHats.append(hat)
		p1.piggyBank = p1.piggyBank - price
		AccessUsers.save_user(p1)
		get_tree().reload_current_scene()

func _on_free_money_pressed() -> void:
	AccessUsers.returningUsers()
	if(Global.PlayerOne):
		p1 = Global.PlayerOne
		p1.piggyBank += 1000
		AccessUsers.save_user(p1)
	else:
		p1.userName = "Guest"
	
	$"User Money".text = "You have $" + str(p1.piggyBank)
