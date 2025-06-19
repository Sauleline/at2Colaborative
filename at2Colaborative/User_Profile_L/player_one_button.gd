extends "main.gd"

@onready var PlayerOneButton = $PlayerOneButton 
@onready var PlayerTwoButton = $PlayerTwoButton 

func _ready():
	PlayerOne.set_pressed(true) 
	PlayerTwo.set_pressed(false) 
	

func _on_player_two_button_pressed() -> void:
	PlayerOne.set_pressed(false) 
	
	

	
